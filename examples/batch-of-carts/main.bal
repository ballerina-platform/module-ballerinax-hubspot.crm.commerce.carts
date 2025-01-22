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
import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.commerce.carts as hscarts;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

// Create a new client using the provided configuration
hscarts:ConnectionConfig config = {
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    }
};
final hscarts:Client hubspotCarts = check new (config);

public function main() returns error? {

    //Create a new batch of carts
    hscarts:BatchInputSimplePublicObjectInputForCreate createBatchRequest = {
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
            },
            {
                properties: {
                    "hs_source_store": "T Cafe",
                    "hs_total_price": "200",
                    "hs_currency_code": "USD",
                    "hs_tax": "17.25",
                    "hs_tags": "sandwiches, coffee"
                }
            }
        ]
    };

    hscarts:BatchResponseSimplePublicObject createBatchResponse = check hubspotCarts->/carts/batch/create.post(createBatchRequest);
    io:println(`A new cart has been created with ID ${createBatchResponse.results[0]["id"]} ${"\n"}A new cart has been created with ID ${createBatchResponse.results[1]["id"]} ${"\n"}A new cart has been created with ID ${createBatchResponse.results[2]["id"]} ${"\n"}`);

    //Read a batch of carts by internal Id 
    string cartId1 = createBatchResponse.results[0].id;
    string cartId2 = createBatchResponse.results[1].id;
    string cartId3 = createBatchResponse.results[2].id;
    hscarts:BatchReadInputSimplePublicObjectId readBatchRequest = {
        inputs: [
            {
                id: cartId1
            },
            {
                id: cartId2
            },
            {
                id: cartId3
            }
        ],
        properties: [
            "hs_source_store",
            "hs_total_price",
            "hs_tags"
        ]
    };

    hscarts:BatchResponseSimplePublicObject|hscarts:BatchResponseSimplePublicObjectWithErrors readBatchResponse = check hubspotCarts->/carts/batch/read.post(readBatchRequest);
    io:println(`Fetched details for cart ID ${cartId1}: ${readBatchResponse.results[0]} ${"\n"}Fetched details for cart ID ${cartId2}: ${readBatchResponse.results[1]} ${"\n"}Fetched details for cart ID ${cartId3}: ${readBatchResponse.results[2]} ${"\n"}`);

    //Update a Batch of Carts
    hscarts:BatchInputSimplePublicObjectBatchInput updateBatchRequest = {
        inputs: [
            {
                id: cartId1,
                properties: {
                    "hs_total_price": "450",
                    "hs_cart_discount": "10"
                }
            },
            {
                id: cartId2,
                properties: {
                    "hs_total_price": "370",
                    "hs_cart_discount": "10"
                }
            },
            {
                id: cartId3,
                properties: {
                    "hs_total_price": "180",
                    "hs_cart_discount": "10"
                }
            }
        ]
    };

    hscarts:BatchResponseSimplePublicObject|hscarts:BatchResponseSimplePublicObjectWithErrors updateBatchResponse = check hubspotCarts->/carts/batch/update.post(updateBatchRequest);
    io:println(`Carts with IDs ${updateBatchResponse.results[0]["id"]}, ${updateBatchResponse.results[1]["id"]}, and ${updateBatchResponse.results[2]["id"]} have been updated suceessfully.${"\n"}`);

    //Archive a Batch of Carts by ID
    hscarts:BatchInputSimplePublicObjectId archiveBatchRequest = {
        inputs: [
            {
                id: cartId1
            },
            {
                id: cartId2
            },
            {
                id: cartId3
            }
        ]
    };

    http:Response archiveBatchResponse = check hubspotCarts->/carts/batch/archive.post(archiveBatchRequest);
    io:println(`Carts with IDs ${cartId1}, ${cartId2}, and ${cartId3} have been archived. HTTP resonse status code: ${archiveBatchResponse.statusCode} ${"\n"}`);
}
