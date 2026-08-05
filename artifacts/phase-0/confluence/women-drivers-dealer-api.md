---
source: DAS Confluence
page_id: 3171680294
title: Women-Drivers.com Dealer API
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3171680294
type: confluence-doc
repulled: 2026-06-09
---

\
Updated: March 18, 2020\
\
Authentication\
All requests must include the WDApiAuthToken header with a value that has access to the requested dealer ID.\
\
All requests must be made via https.\
\
Format\
Requesters can specify XML or JSON using standard values in the Accept header\
\
Get Dealer Contact Information\
GET https://api.women-drivers.com/dealer/{dealer_ID}/contact\
Fetches Modifiable contact info for a dealer\
\
Returns an object like\
{\
"Address": "1111 Test Dr",\
"City": "Test",\
"State": "TX",\
"Zip": "76543",\
"SalesPhone": "5555555555",\
"ServicePhone": "5555555555",\
"Website": "www.something.net",\
"Email": "somebody@example.com"\
}\
\
Update Dealer Contact Information\
PUT https://api.women-drivers.com/dealer/{dealer_ID}/contact\
Updates a dealer’s contact info\
\
Request body is an object in the same format as the Get Dealer Contact Information response above,\
but only values that are being updated need to be supplied. For example, to change the website:\
{\
"Website": "www.something.com"\
}\
\
Returns the full updated dealer contact info as in the GET request.\
If no changes were required, this will return status 304\
\
Get Dealer Reviews\
GET https://api.women-drivers.com/dealer/{dealer_ID}/reviews\
Fetches all reviews with responses for the given dealer\
\
Returns an object like:\
{\
"DealerId": 21719,\
"DealerGuid": "08e734c8-308e-48fa-aee4-b8fdaa413f77",\
"RatingUrl": "http://www.women-drivers.com/Certified-Dealer-Test",\
"ReviewsUrl": "http://www.women-drivers.com/reviews.aspx?dealer_guid=08e734c8-308e-48fa-aee4-\
b8fdaa413f77",\
"Name": "Certified Dealer Demo",\
"ReviewCount": 24,\
"Ratings": {\
"OverallRating": 4.68,\
"ShoppingRating": 4.82,\
"PurchaseRating": 4.91,\
"ServiceRating": 5\
},\
"Reviews": \[\
{\
"ReviewId": 5448,\
"User": {\
"FName": "jontest4",\
"LastInit": "s"\
},\
"DateWritten": "06/20/2016",\
"Comments": "##tewt##",\
"RatingCategory": "purchase",\
"Rating": 4.8,\
"Responses": \[\
{\
"DateEntered": "2016-12-09T17:08:29.907",\
"ResponseText": "Hello this is a test response"\
}\
\]\
}\
\]\
}\

Respond to a Dealer Review\
POST https://api.women-drivers.com/review/{review_ID}/response\
Adds a dealer response to the given user review\
Request body is an object like:\
{\
"ResponseText": "The response text goes here"\
}\
Returns HTTP 201 Created if all went well, and triggers email to the user that a response has been posted\

Add a Dealer Review\
There are three types of reviews that you can add using this API.\
1) Service Review (ReviewCategory =1)\
2) Purchase Review (ReviewCategory =2)\
3) Browse Review (ReviewCategory =3)\
\
POST https://api.women-drivers.com/review/{dealer_id}/addreview\
You will have to add user information along with the review in the request. The API will check if there is\
any user in the system against the provided email address. If the user does not exist then the API will\
add the user first and then will add the review attributed to that user. If user is new then you also need\
to provide user's first name, last name and password.\
Note that the content type should be application/json\

Emoji:\
Emoji field should only have one of the following values:\
1: Like\
2: Love\
3: Excited\
4: Not So Hot\
5: Frustrated\

Sample Service Review Request:\
{\
"ReviewCategory": 2,\
Make:"acura",\
Emoji: "Like",\
"Comment": "This is a test comment",\
"User": {\
"FName": "John",\
"LastName": "Smith",\
"Email": "john.smith@gmail.com",\
"Password": "asdfghjkl"\
},\
"Review":\[5,4,5,4,3\]\
}\

Get a Dealer ID\
GET https://api.women-drivers.com/dealer/{dealer_guid}/GetDealerID\
\
This function will return a dealerID given the Dealer Guid. The DealerIDs are used throughout most of the API.

[<span>WD_Dealer_API.docx</span>](/wiki/spaces/Technology/pages/3171680294/Women-Drivers.com+Dealer+API?preview=%2F3171680294%2F3172401165%2FWD_Dealer_API.docx)\
