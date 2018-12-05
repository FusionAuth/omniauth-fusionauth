#
# Copyright (c) 2018, FusionAuth, All Rights Reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#

#
#  Note: This code is not yet functional or published. Use - are attempt to use at your own risk.
#

# OAUTH_ROOT=<My FusionAuth Domain>
# OAUTH_AUTHORIZE_PATH=/oauth2/authorize
# OAUTH_TOKEN_PATH=/oauth2/token
# OAUTH_USERINFO_PATH=/oauth2/userinfo
# DOMAIN=http://localhost:9021

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider(
#     :fusionauth,
#     ENV['OAUTH_CLIENT_ID'],
#     ENV['OAUTH_CLIENT_SECRET'],
#     { scope: 'openid' }
#   )
# end

require 'omniauth'

module OmniAuth
  module Strategies
    class FusionAuth < OmniAuth::Strategies::OAuth2
      option :name, 'fusionauth'
      option :client_options, {
          site: ENV['OAUTH_ROOT'],
          authorize_url: ENV['OAUTH_AUTHORIZE_PATH'],
          token_url: ENV['OAUTH_TOKEN_PATH']
      }

      option :token_params, {
          redirect_uri: "#{ENV['DOMAIN']}/auth/fusion_auth/callback"
      }

      uid{ raw_info['sub'] }

      info do
        {
            :email => raw_info['email']
        }
      end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get(ENV['OAUTH_USERINFO_PATH']).parsed
      end
    end
  end
end
