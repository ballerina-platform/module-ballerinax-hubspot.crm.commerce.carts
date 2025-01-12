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

service on new http:Listener(9090) {

    resource function post carts(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject {
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

    resource function get carts() returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging {
        return {
            "paging": {
                "next":
                {
                    "link": "https://api.hubapi.com/crm/v3/objects/carts?archived=false&limit=10&after=394810829346",
                    "after": "394810829346"
                }
            },
            "results": [
                {
                    "createdAt": "2025-01-03T09:44:44.245Z",
                    "archived": false,
                    "id": "394586508127",
                    "properties": {
                        "hs_lastmodifieddate": "2025-01-03T09:44:44.835Z",
                        "hs_createdate": "2025-01-03T09:44:44.245Z",
                        "hs_object_id": "394586508127"
                    },
                    "updatedAt": "2025-01-03T09:44:44.835Z"
                },
                {
                    "createdAt": "2025-01-03T09:47:16.663Z",
                    "archived": false,
                    "id": "394588289922",
                    "properties": {
                        "hs_lastmodifieddate":
                        "2025-01-04T14:30:17.034Z",
                        "hs_createdate": "2025-01-03T09:47:16.663Z",
                        "hs_object_id": "394588289922"
                    },
                    "updatedAt": "2025-01-04T14:30:17.034Z"
                },
                {
                    "createdAt": "2025-01-03T10:22:14.482Z",
                    "archived": false,
                    "id": "394596174256",
                    "properties": {
                        "hs_lastmodifieddate": "2025-01-03T10:22:14.898Z",
                        "hs_createdate": "2025-01-03T10:22:14.482Z",
                        "hs_object_id": "394596174256"
                    },
                    "updatedAt": "2025-01-03T10:22:14.898Z"
                }
            ]
        };
    }

    resource function get carts/[string cartId]() returns SimplePublicObjectWithAssociations {
        return {
            "createdAt": "2025-01-03T09:47:16.663Z",
            "archived": false,
            "id": "394588289922",
            "properties": {
                "hs_lastmodifieddate": "2025-01-04T14:30:17.034Z",
                "hs_createdate": "2025-01-03T09:47:16.663Z",
                "hs_object_id": "394588289922"
            },
            "updatedAt": "2025-01-04T14:30:17.034Z"
        };
    }

    resource function patch carts/[string cartId](@http:Payload SimplePublicObjectInput payload) returns SimplePublicObject {
        return {
            "createdAt": "2025-01-03T09:47:16.663Z",
            "archived": false,
            "id": "394588289922",
            "properties": {
                "hs_lastmodifieddate": "2025-01-04T14:30:17.034Z",
                "hs_object_source_id": "5673172",
                "hs_createdate": "2025-01-03T09:47:16.663Z",
                "hs_object_id": "394588289922",
                "hs_object_source": "INTEGRATION",
                "hs_tax": "48.75",
                "hs_object_source_label": "INTEGRATION"
            },
            "updatedAt": "2025-01-04T14:30:17.034Z"
        };
    }

    resource function post carts/batch/create(@http:Payload BatchInputSimplePublicObjectInputForCreate payload) returns BatchResponseSimplePublicObject {
        return {
            "completedAt": "2025-01-12T02:49:49.571Z",
            "startedAt": "2025-01-12T02:49:49.440Z",
            "results": [
                {
                    "createdAt": "2025-01-12T02:49:49.489Z",
                    "archived": false,
                    "id": "396471635864",
                    "properties": {
                        "hs_homecurrency_amount": "500.0",
                        "hs_source_store": "ABC Cafe",
                        "hs_tax": "36.25",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_currency_code": "USD",
                        "hs_exchange_rate": "1.0",
                        "hs_lastmodifieddate": "2025-01-12T02:49:49.489Z",
                        "hs_object_source_id": "5673172",
                        "hs_total_price": "500",
                        "hs_createdate": "2025-01-12T02:49:49.489Z",
                        "hs_object_id": "396471635864",
                        "hs_object_source": "INTEGRATION",
                        "hs_tags": "donuts, coffee"
                    },
                    "updatedAt": "2025-01-12T02:49:49.489Z"
                },
                {
                    "createdAt": "2025-01-12T02:49:49.489Z",
                    "archived": false,
                    "id": "396471635863",
                    "properties": {
                        "hs_homecurrency_amount": "400.0",
                        "hs_source_store": "XYZ Cafe",
                        "hs_tax": "23.25",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_currency_code": "USD",
                        "hs_exchange_rate": "1.0",
                        "hs_lastmodifieddate": "2025-01-12T02:49:49.489Z",
                        "hs_object_source_id": "5673172",
                        "hs_total_price": "400",
                        "hs_createdate": "2025-01-12T02:49:49.489Z",
                        "hs_object_id": "396471635863",
                        "hs_object_source": "INTEGRATION",
                        "hs_tags": "bagels, tea"
                    },
                    "updatedAt": "2025-01-12T02:49:49.489Z"
                }
            ],
            "status": "COMPLETE"
        };
    }

    resource function post carts/batch/read(@http:Payload BatchReadInputSimplePublicObjectId payload) returns BatchResponseSimplePublicObject {
        return {
            "completedAt": "2025-01-12T03:05:40.824Z",
            "startedAt": "2025-01-12T03:05:40.800Z",
            "results": [
                {
                    "createdAt": "2025-01-12T02:49:49.489Z",
                    "archived": false,
                    "id": "396471635864",
                    "properties": {
                        "hs_currency_code": "USD",
                        "hs_lastmodifieddate": "2025-01-12T02:49:50.185Z",
                        "hs_total_price": "500",
                        "hs_createdate": "2025-01-12T02:49:49.489Z",
                        "hs_object_id": "396471635864"
                    },
                    "updatedAt": "2025-01-12T02:49:50.185Z"
                },
                {
                    "createdAt": "2025-01-12T02:49:49.489Z",
                    "archived": false,
                    "id": "396471635863",
                    "properties": {
                        "hs_currency_code": "USD",
                        "hs_lastmodifieddate": "2025-01-12T02:49:49.664Z",
                        "hs_total_price": "400",
                        "hs_createdate": "2025-01-12T02:49:49.489Z",
                        "hs_object_id": "396471635863"
                    },
                    "updatedAt": "2025-01-12T02:49:49.664Z"
                }
            ],
            "status": "COMPLETE"
        };
    }

    resource function post carts/batch/update(@http:Payload BatchInputSimplePublicObjectBatchInput payload) returns BatchResponseSimplePublicObject {
        return {
            "completedAt": "2025-01-12T03:19:44.926Z",
            "startedAt": "2025-01-12T03:19:44.841Z",
            "results": [
                {
                    "createdAt": "2025-01-12T02:49:49.489Z",
                    "archived": false,
                    "id": "396471635864",
                    "properties": {
                        "hs_exchange_rate": "1.0",
                        "hs_cart_discount": "12",
                        "hs_lastmodifieddate": "2025-01-12T03:19:44.859Z",
                        "hs_object_source_id": "5673172",
                        "hs_homecurrency_amount": "485.0",
                        "hs_total_price": "485",
                        "hs_createdate": "2025-01-12T02:49:49.489Z",
                        "hs_object_id": "396471635864",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_label": "INTEGRATION"
                    },
                    "updatedAt": "2025-01-12T03:19:44.859Z"
                },
                {
                    "createdAt": "2025-01-12T02:49:49.489Z",
                    "archived": false,
                    "id": "396471635863",
                    "properties": {
                        "hs_exchange_rate": "1.0",
                        "hs_cart_discount": "10",
                        "hs_lastmodifieddate": "2025-01-12T03:19:44.859Z",
                        "hs_object_source_id": "5673172",
                        "hs_homecurrency_amount": "390.0",
                        "hs_total_price": "390",
                        "hs_createdate": "2025-01-12T02:49:49.489Z",
                        "hs_object_id": "396471635863",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_label": "INTEGRATION"
                    },
                    "updatedAt": "2025-01-12T03:19:44.859Z"
                }
            ],
            "status": "COMPLETE"
        };
    }

    resource function post carts/batch/upsert(@http:Payload BatchInputSimplePublicObjectBatchInputUpsert payload) returns BatchResponseSimplePublicUpsertObject {
        return {
            "completedAt": "2025-01-12T03:36:44.958Z",
            "startedAt": "2025-01-12T03:36:44.900Z",
            "results": [
                {
                    "createdAt": "2025-01-12T03:34:11.942Z",
                    "archived": false,
                    "new": false,
                    "id": "396479728760",
                    "properties": {
                        "hs_homecurrency_amount": "450.0",
                        "hs_source_store": "Dog Cafe",
                        "hs_tax": "13.25",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_currency_code": "USD",
                        "hs_exchange_rate": "1.0",
                        "hs_lastmodifieddate": "2025-01-12T03:34:12.609Z",
                        "hs_object_source_id": "5673172",
                        "hs_total_price": "450",
                        "hs_createdate": "2025-01-12T03:34:11.942Z",
                        "hs_object_id": "396479728760",
                        "hs_object_source": "INTEGRATION",
                        "hs_tags": "bagels, tea"
                    },
                    "updatedAt": "2025-01-12T03:34:12.609Z"
                },
                {
                    "createdAt": "2025-01-12T03:34:11.942Z",
                    "archived": false,
                    "new": false,
                    "id": "396479728759",
                    "properties": {
                        "hs_homecurrency_amount": "350.0",
                        "hs_source_store": "Cat Cafe",
                        "hs_tax": "26.25",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_currency_code": "USD",
                        "hs_exchange_rate": "1.0",
                        "hs_lastmodifieddate": "2025-01-12T03:34:12.338Z",
                        "hs_object_source_id": "5673172",
                        "hs_total_price": "350",
                        "hs_createdate": "2025-01-12T03:34:11.942Z",
                        "hs_object_id": "396479728759",
                        "hs_object_source": "INTEGRATION",
                        "hs_tags": "donuts, coffee"
                    },
                    "updatedAt": "2025-01-12T03:34:12.338Z"
                }
            ],
            "status": "COMPLETE"
        };
    }

    resource function post carts/search(@http:Payload PublicObjectSearchRequest payload) returns CollectionResponseWithTotalSimplePublicObjectForwardPaging {
        return {
            "total": 3,
            "results": [
                {
                    "createdAt": "2025-01-10T13:30:50.588Z",
                    "archived": false,
                    "id": "396061406496",
                    "properties": {
                        "hs_lastmodifieddate": "2025-01-10T13:30:51.796Z",
                        "hs_external_cart_id": null,
                        "hs_createdate": "2025-01-10T13:30:50.588Z",
                        "hs_source_store": "Dog Cafe",
                        "hs_object_id": "396061406496"
                    },
                    "updatedAt": "2025-01-10T13:30:51.796Z"
                },
                {
                    "createdAt": "2025-01-10T13:31:06.083Z",
                    "archived": false,
                    "id": "396059581456",
                    "properties": {
                        "hs_lastmodifieddate": "2025-01-10T13:31:07.159Z",
                        "hs_external_cart_id": null,
                        "hs_createdate": "2025-01-10T13:31:06.083Z",
                        "hs_source_store": "Dog Cafe",
                        "hs_object_id": "396059581456"
                    },
                    "updatedAt": "2025-01-10T13:31:07.159Z"
                },
                {
                    "createdAt": "2025-01-12T03:34:11.942Z",
                    "archived": false,
                    "id": "396479728760",
                    "properties": {
                        "hs_lastmodifieddate": "2025-01-12T03:34:12.609Z",
                        "hs_external_cart_id": null,
                        "hs_createdate": "2025-01-12T03:34:11.942Z",
                        "hs_source_store": "Dog Cafe",
                        "hs_object_id": "396479728760"
                    },
                    "updatedAt": "2025-01-12T03:34:12.609Z"
                }
            ]
        };
    }

    resource function post carts/batch/archive(@http:Payload BatchInputSimplePublicObjectId payload) returns http:Response {
        http:Response response = new;
        if payload.inputs.length() > 0 {
            response.statusCode = http:STATUS_NO_CONTENT;
        } else {
            response.statusCode = http:STATUS_BAD_REQUEST;
        }
        return response;

    }

    resource function delete carts/[string cartId]() returns http:Response {
        http:Response response = new;
        response.statusCode = http:STATUS_NO_CONTENT;
        return response;

    }
};
