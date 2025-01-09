// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {

    resource function post crm/v3/objects/carts(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject|error {
        return {
            "createdAt": "2025-01-09T06:17:18.389Z",
            "archived": false,
            "id": "395712290715",
            "properties": {
                "hs_homecurrency_amount": "500.0",
                "hs_source_store": "Dog Cafe - Italy",
                "hs_tax": "36.25",
                "hs_object_source_label": "INTEGRATION",
                "hs_currency_code": "USD",
                "hs_exchange_rate": "1.0",
                "hs_lastmodifieddate": "2025-01-09T06:17:18.389Z",
                "hs_object_source_id": "5673172",
                "hs_total_price": "500",
                "hs_createdate": "2025-01-09T06:17:18.389Z",
                "hs_object_id": "395712290715",
                "hs_object_source": "INTEGRATION",
                "hs_tags": "donuts, bagels"
            },
            "updatedAt": "2025-01-09T06:17:18.389Z"
        };
    }

    resource function post crm/v3/objects/batch/create(@http:Payload BatchInputSimplePublicObjectInputForCreate payload) returns BatchResponseSimplePublicObject|error {
        return {
            "completedAt": "2025-01-09T04:46:13.267Z",
            "startedAt": "2025-01-09T04:46:13.117Z",
            "results": [
                {
                    "createdAt": "2025-01-09T04:46:13.149Z",
                    "archived": false,
                    "id": "395709371997",
                    "properties": {
                        "hs_homecurrency_amount": "500.0",
                        "hs_source_store": "ABC Cafe - USA",
                        "hs_tax": "36.25",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_currency_code": "USD",
                        "hs_exchange_rate": "1.0",
                        "hs_lastmodifieddate": "2025-01-09T04:46:13.149Z",
                        "hs_object_source_id": "5673172",
                        "hs_total_price": "500",
                        "hs_createdate": "2025-01-09T04:46:13.149Z",
                        "hs_object_id": "395709371997",
                        "hs_object_source": "INTEGRATION",
                        "hs_tags": "donuts, bagels"
                    },
                    "updatedAt": "2025-01-09T04:46:13.149Z"
                }
            ],
            "status": "COMPLETE"
        };
    }
};

function init() returns error? {
    log:printInfo("Initializing mock service");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}
