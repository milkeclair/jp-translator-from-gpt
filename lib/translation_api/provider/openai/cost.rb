# frozen_string_literal: true

class TranslationAPI
  module Provider
    class OpenAI
      class Cost
        ONE_MILLION = 1_000_000

        def initialize(model)
          @model = model
        end

        def input_cost(used_tokens)
          calculate_cost(used_tokens, :input)
        end

        def output_cost(used_tokens)
          calculate_cost(used_tokens, :output)
        end

        private

        def calculate_cost(used_tokens, type)
          used_tokens * token_rates[@model.name][type]
        end

        def token_rates
          base.merge(mini).merge(nano)
        end

        def base
          {
            @model.class.base => {
              input: 2.50 / ONE_MILLION,
              output: 15.00 / ONE_MILLION
            }
          }
        end

        def mini
          {
            @model.class.mini => {
              input: 0.75 / ONE_MILLION,
              output: 4.50 / ONE_MILLION
            }
          }
        end

        def nano
          {
            @model.class.nano => {
              input: 0.20 / ONE_MILLION,
              output: 1.25 / ONE_MILLION
            }
          }
        end
      end
    end
  end
end
