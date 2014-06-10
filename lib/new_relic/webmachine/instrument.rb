require "new_relic/agent/instrumentation"
require "new_relic/agent/instrumentation/controller_instrumentation"

module NewRelic
  module Agent
    module Instrumentation
      module Webmachine

        module FSM

          include NewRelic::Agent::Instrumentation::ControllerInstrumentation

          def run_with_newrelic
            trace_params = {
              :category => :controller,
              :class_name => resource.class.name,
              :name => request.method,
              :request => NewRelicRequest.new(request),
              :params => request.query.merge(request.path_info || {})
            }
            perform_action_with_newrelic_trace(trace_params) do
              run_without_newrelic
            end
          end

          private

          def handle_exceptions_with_newrelic
            handle_exceptions_without_newrelic do
              begin
                yield
              rescue Exception => e
                ::NewRelic::Agent.notice_error(e)
                raise e
              end
            end
          end

        end

        # Encapsulates what New Relic wants to know about requests.
        # This is necessary because we can't (easily) get a Rack::Request.
        #
        class NewRelicRequest

          def initialize(wm_request)
            @wm_request = wm_request
          end

          def uri
            @wm_request.uri.to_s
          end

          def referer
            @wm_request["HTTP_REFERER"]
          end

          def cookies
            @wm_request.cookies
          end

        end

      end
    end
  end
end

DependencyDetection.defer do

  @name = :webmachine

  depends_on do
    defined?(::Webmachine) && ! ::NewRelic::Control.instance['disable_webmachine'] && ! ENV['DISABLE_NEW_RELIC_WEBMACHINE']
  end

  executes do
    NewRelic::Agent.logger.info "Installing Webmachine instrumentation"
  end

  executes do
    ::Webmachine::Decision::FSM.class_eval do
      include NewRelic::Agent::Instrumentation::Webmachine::FSM
      alias run_without_newrelic run
      alias run run_with_newrelic
      alias handle_exceptions_without_newrelic handle_exceptions
      alias handle_exceptions handle_exceptions_with_newrelic
    end
  end

end
