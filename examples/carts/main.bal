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
final hscarts:Client hubspot = check new (config);

public function main() returns error? {

    //Create a new Cart
    hscarts:SimplePublicObjectInputForCreate createCartRequest = {
        properties: {
            "hs_source_store": "Dog Cafe - Italy",
            "hs_total_price": "500",
            "hs_currency_code": "USD",
            "hs_tax": "36.25",
            "hs_tags": "donuts, bagels"
        }
    };
    hscarts:SimplePublicObject createCartResponse = check hubspot->/carts.post(payload = createCartRequest);
    io:println("Created Cart : ", createCartResponse, "\n");

    //Get a Cart by its' id
    string cartId = createCartResponse.id;
    hscarts:SimplePublicObjectWithAssociations getCartResponse = check hubspot->/carts/[cartId]();
    io:println("Cart Details for Cart ID - ", cartId, " : ", getCartResponse, "\n");

    //Update the Cart
    hscarts:SimplePublicObjectInput updateCartRequest = {
        properties: {
            "hs_tax": "48.75"
        }
    };
    hscarts:SimplePublicObject updateCartResponse = check hubspot->/carts/[cartId].patch(payload = updateCartRequest);
    io:println("Updated Cart : ", updateCartResponse, "\n");

    //Search Carts
    hscarts:PublicObjectSearchRequest searchCartRequest = {
        filterGroups: [
            {
                filters: [
                    {
                        propertyName: "hs_tags",
                        value: "donuts, bagels",
                        operator: "EQ"
                    }
                ]
            }
        ],
        properties: [
            "hs_source_store",
            "hs_total_price"
        ]
    };

    hscarts:CollectionResponseWithTotalSimplePublicObjectForwardPaging searchCartResponse = check hubspot->/carts/search.post(searchCartRequest);
    io:println("Search Results : ", searchCartResponse.results, "\n");

    //Delete the Cart
    http:Response deleteCartResponse = check hubspot->/carts/[cartId].delete();
    io:println("Cart with ID - ", cartId, " is deleted, HTTP response status code : ", deleteCartResponse.statusCode, "\n");
}
