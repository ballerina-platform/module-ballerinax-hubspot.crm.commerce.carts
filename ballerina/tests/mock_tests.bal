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

import ballerina/test;

final Client mockClient = check new (config);

//Create a new Cart
@test:Config {}
isolated function mockTestCreateCart() returns error? {

    SimplePublicObjectInputForCreate payload = {
        "properties": {
            "hs_cart_name": "Optic",
            "hs_external_cart_id": "1234567890",
            "hs_external_status": "pending",
            "hs_source_store": "XYZ - USA",
            "hs_total_price": "500",
            "hs_currency_code": "USD",
            "hs_cart_discount": "12",
            "hs_tax": "36.25",
            "hs_shipping_cost": "0",
            "hs_tags": "frames, lenses"
        }
    };

    SimplePublicObject response = check mockClient->/carts.post(payload = payload);
    test:assertTrue(response?.id !is "");
}

//Create a new Batch
@test:Config {}
isolated function mockTestCreateBatch() returns error? {
    BatchInputSimplePublicObjectInputForCreate payload = {
        "inputs": [
            {
                "properties": {
                    "hs_source_store": "ABC Cafe - USA",
                    "hs_total_price": "500",
                    "hs_currency_code": "USD",
                    "hs_tax": "36.25",
                    "hs_tags": "donuts, bagels"
                }
            }
        ]
    };

    BatchResponseSimplePublicObject response = check mockClient->/carts/batch/create.post(payload);
    test:assertTrue(response.results[0]["id"] !is "");
}
