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
        clientId: clientId,
        clientSecret: clientSecret,
        refreshToken: refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    }
};
final hscarts:Client baseClient = check new hscarts:Client(config);

public function main() returns error? {

    //Create a new batch of carts
    hscarts:BatchInputSimplePublicObjectInputForCreate batchCreatePayload = {
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

    hscarts:BatchResponseSimplePublicObject newBatch = check baseClient->/carts/batch/create.post(batchCreatePayload);
    io:println("Created Batch : ", newBatch);

    //Read a batch of carts by internal Id 
    string batchId = newBatch.results[0].id;
    hscarts:BatchReadInputSimplePublicObjectId batchReadPayload = {
        "inputs": [
            {
                "id": batchId
            }
        ],
        "properties": [
            "hs_total_price",
            "hs_currency_code"
        ]
    };

    hscarts:BatchResponseSimplePublicObject|hscarts:BatchResponseSimplePublicObjectWithErrors batchResponse = check baseClient->/carts/batch/read.post(batchReadPayload);
    io:println("Fetched Batch Details : ", batchResponse);

    //Update a Batch of Carts
    hscarts:BatchInputSimplePublicObjectBatchInput batchUpdatePayload = {
        "inputs": [
            {
                "id": batchId,
                "properties": {
                    "hs_total_price": "543",
                    "hs_tax": "79.25"
                }
            }
        ]
    };

    hscarts:BatchResponseSimplePublicObject|hscarts:BatchResponseSimplePublicObjectWithErrors updatedResponse = check baseClient->/carts/batch/update.post(batchUpdatePayload);
    io:println("Updated Batch : ", updatedResponse);

    //Archive a Batch of Carts by ID
    hscarts:BatchInputSimplePublicObjectId batchArchivePayload = {
        "inputs": [
            {
                "id": batchId
            }
        ]
    };

    http:Response ArchiveHttpResponse = check baseClient->/carts/batch/archive.post(batchArchivePayload);
    io:println("Batch with ID - ", batchId, " is archived, HTTP response status code : ", ArchiveHttpResponse.statusCode);

}
