import ballerinax/hubspot.crm.commerce.carts as hscarts;
import ballerina/oauth2;
import ballerina/io;
import ballerina/http;

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

    //Create a new Cart
    hscarts:SimplePublicObjectInputForCreate cartPayload = {
      "properties": {
        "hs_source_store": "Dog Cafe - Italy",
        "hs_total_price": "500",
        "hs_currency_code": "USD",
        "hs_tax": "36.25",
        "hs_tags": "donuts, bagels"
      }
    };
    hscarts:SimplePublicObject newCart =  check baseClient ->/carts.post(payload = cartPayload);
    io:println("Created Cart : ",newCart);

    //Get a Cart by its' id
    string cartId = newCart.id;
    hscarts:SimplePublicObjectWithAssociations cartResponse = check baseClient->/carts/[cartId]();
    io:println("Cart Details for Cart ID - ",cartId," : ", cartResponse);

    //Update the Cart
    hscarts:SimplePublicObjectInput cartUpdateDetails = {
        "properties": {
        "hs_tax": "48.75"
        }
    };
    hscarts:SimplePublicObject updatedCart = check baseClient->/carts/[cartId].patch(payload = cartUpdateDetails);
    io:println("Updated Cart : ",updatedCart);

    //Search Carts
    hscarts:PublicObjectSearchRequest cartSearchPayload = {
        "filterGroups": [
            {
                "filters": [
                    {
                        "propertyName": "hs_source_store",
                        "value": "Dog Cafe - Italy",
                        "operator": "EQ"
                    }
                ]
            }
        ],
        "properties": ["hs_external_cart_id", "hs_source_store"]
    };

    hscarts:CollectionResponseWithTotalSimplePublicObjectForwardPaging serchResponse = check baseClient->/carts/search.post(cartSearchPayload);
    io:println("Search Results : ",serchResponse.results);

    //Delete the Cart
    http:Response response = check baseClient->/carts/[cartId].delete();
    io:println("Cart with ID - ",cartId,"is deleted, HTTP response status code : ",response.statusCode);
}
    
