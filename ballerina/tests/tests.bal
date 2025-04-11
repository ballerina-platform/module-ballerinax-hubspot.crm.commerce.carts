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

import ballerina/oauth2;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v3/objects" : "http://localhost:9090";

final string clientId = os:getEnv("HUBSPOT_CLIENT_ID");
final string clientSecret = os:getEnv("HUBSPOT_CLIENT_SECRET");
final string refreshToken = os:getEnv("HUBSPOT_REFRESH_TOKEN");

final Client hubspot = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, serviceUrl);
    }
    return check new ({
        auth: {
            token: "test-token"
        }
    }, serviceUrl);
}

//Create a new Cart
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateCart() returns error? {

    SimplePublicObjectInputForCreate payload = {
        properties: {
            "hs_cart_name": "Optic",
            "hs_external_cart_id": "1234567890",
            "hs_external_status": "pending",
            "hs_source_store": "XYZ - USA",
            "hs_total_price": "500",
            "hs_currency_code": "USD",
            "hs_cart_discount": "12",
            "hs_tax": "36.25",
            "hs_tags": "frames, lenses"
        }
    };

    SimplePublicObject response = check hubspot->/carts.post(payload = payload);
    test:assertTrue(response?.id !is "");
}

//Get all carts
@test:Config {
    dependsOn: [testCreateCart],
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetAllCarts() returns error? {

    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspot->/carts;
    test:assertTrue(response?.results.length() > 0);
};

//Get Cart by Id
@test:Config {
    dependsOn: [testCreateCart],
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetCartByID() returns error? {

    string cartId = "394588289922";

    SimplePublicObjectWithAssociations response = check hubspot->/carts/[cartId]();
    test:assertEquals(response?.id, cartId);
}

//Update a Cart
@test:Config {
    dependsOn: [testGetCartByID],
    groups: ["live_tests", "mock_tests"]
}
isolated function testUpdateCart() returns error? {

    SimplePublicObjectInput payload = {
        properties: {
            "hs_tax": "48.75"
        }
    };

    string cartId = "394588289922";

    SimplePublicObject response = check hubspot->/carts/[cartId].patch(payload = payload);
    test:assertEquals(response?.id, cartId);
    test:assertEquals(response?.properties["hs_tax"], payload.properties["hs_tax"]);
}

//Create a new Batch
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateBatch() returns error? {
    BatchInputSimplePublicObjectInputForCreate payload = {
        inputs: [
            {
                properties: {
                    "hs_source_store": "ABC Cafe",
                    "hs_total_price": "500",
                    "hs_currency_code": "USD",
                    "hs_tax": "36.25",
                    "hs_tags": "donuts, coffee"
                }
            },
            {
                properties: {
                    "hs_source_store": "XYZ Cafe",
                    "hs_total_price": "400",
                    "hs_currency_code": "USD",
                    "hs_tax": "23.25",
                    "hs_tags": "bagels, tea"
                }
            }
        ]
    };

    BatchResponseSimplePublicObject response = check hubspot->/carts/batch/create.post(payload);
    test:assertTrue(response?.results.length() > 0);
}

//Read a batch
@test:Config {
    dependsOn: [testCreateBatch],
    groups: ["live_tests", "mock_tests"]
}
isolated function testReadBatch() returns error? {

    BatchReadInputSimplePublicObjectId payload = {
        inputs: [
            {
                "id": "396471635863"
            },
            {
                "id": "396471635864"
            }
        ],
        properties: [
            "hs_total_price",
            "hs_currency_code"
        ]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/carts/batch/read.post(payload);
    test:assertTrue(response?.results.length() > 0);
}

//Update a Batch
@test:Config {
    dependsOn: [testReadBatch],
    groups: ["live_tests", "mock_tests"]
}

isolated function testUpdateBatch() returns error? {
    BatchInputSimplePublicObjectBatchInput payload = {
        inputs: [
            {
                id: "396471635864",
                properties: {
                    "hs_total_price": "485",
                    "hs_cart_discount": "12"
                }
            },
            {
                id: "396471635863",
                properties: {
                    "hs_total_price": "390",
                    "hs_cart_discount": "10"
                }
            }
        ]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/carts/batch/update.post(payload);
    test:assertTrue(response?.results.length() > 0);
}

//Upsert a Batch 
@test:Config {
    dependsOn: [testUpdateBatch],
    groups: ["live_tests", "mock_tests"]
}
isolated function testUpsertBatch() returns error? {

    BatchInputSimplePublicObjectBatchInputUpsert payload = {
        inputs: [
            {
                "idProperty": "custom_hs_cart_url",
                "id": "https://cart_url_1",
                "properties": {
                    "hs_source_store": "Cat Cafe",
                    "hs_total_price": "350",
                    "hs_currency_code": "USD",
                    "hs_tax": "26.25",
                    "hs_tags": "donuts, coffee"
                }
            },
            {
                "idProperty": "custom_hs_cart_url",
                "id": "https://cart_url_2",
                "properties": {
                    "hs_source_store": "Dog Cafe",
                    "hs_total_price": "450",
                    "hs_currency_code": "USD",
                    "hs_tax": "13.25",
                    "hs_tags": "bagels, tea"
                }
            }
        ]
    };

    BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors response = check hubspot->/carts/batch/upsert.post(payload);
    test:assertTrue(response?.results.length() > 0);
}

//Serch a cart
@test:Config {
    dependsOn: [testUpdateCart, testUpsertBatch],
    groups: ["live_tests", "mock_tests"]
}
isolated function testSearchCarts() returns error? {

    PublicObjectSearchRequest payload = {
        filterGroups: [
            {
                filters: [
                    {
                        "propertyName": "hs_tags",
                        "value": "donuts, bagels",
                        "operator": "EQ"
                    }
                ]
            }
        ],
        properties: [
            "hs_source_store",
            "hs_total_price"
        ]
    };

    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubspot->/carts/search.post(payload);
    test:assertTrue(response?.total > 0);
}

//Archive a Batch
@test:Config {
    dependsOn: [testUpsertBatch],
    groups: ["live_tests", "mock_tests"]
}
isolated function testArchiveBatch() returns error? {

    BatchInputSimplePublicObjectId payload = {
        inputs: [
            {
                id: "395023608593"
            },
            {
                id: "396492105619"
            }
        ]
    };

    _ = check hubspot->/carts/batch/archive.post(payload);
}

//Delete a cart
@test:Config {
    dependsOn: [testUpdateCart],
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteCart() returns error? {

    string cartId = "396479728760";

    _ = check hubspot->/carts/[cartId].delete();
}
