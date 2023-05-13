# E-Missi Home Service

The main objective of this project is to create an “E-Missi Home Service (Hybrid – Android + iOS)” .Huawei Gallery application for End users and service providers where register themselves through mobile number (prior to admin approval), 
availability button, create their profile, update their qualification, accept booking, manage booking status, making call to the end-user and report of work completion, upload photos and submit the report needed and user can register themselves through mobile number, add their own profile, add their dependent profile (if any), book a nurse service, upload photos for the service, 
manage bookings, pay online for their booking, and review the service of the nurse.

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
http://192.168.10.23/flutter/e-missi-home-service-flutter-1843.git

```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 

```
**Step 3:**

Open terminal and run following command:

```
flutter packages pub run build_runner build

```

## Build With flutter

for android

```
flutter build apk --release
```

for ios

```
flutter build ios

```

Base over getx with MVC Architecture

#### MVC Architecture

- `Model`[data]
- `View` [ui]
- `Controller`[logic & operation]

#### Flow of The App

- `Binding` [It binds the Controller, Provider and Repository in self to observe changes]
- `GetMaterialAPP` [GetMaterialController]
- `Controller` [Invoke API]
- `Repository` [Fired and return response or error]
- `Provider` [Set data in model]
- `Controller` [update dependencies]

#### Http Response Codes Summary
    200: OK. Everything worked as expected.
    201: A resource was successfully created in response to a POST request. The Location header contains the URL pointing to the newly created resource.
    204: The request was handled successfully and the response contains no body content (like a DELETE request).
    304: The resource was not modified. You can use the cached version.
    400: Bad request. This could be caused by various actions by the user, such as providing invalid JSON data in the request body, providing invalid action parameters, etc.
    401: Authentication failed.
    403: The authenticated user is not allowed to access the specified API endpoint.
    404: The requested resource does not exist.
    405: Method not allowed. Please check the Allow header for the allowed HTTP methods.
    415: Unsupported media type. The requested content type or version number is invalid.
    422: Data validation failed (in response to a POST request, for example). Please check the response body for detailed error messages.
    429: Too many requests. The request was rejected due to rate limiting.
    500: Internal server error. This could be caused by internal program errors.

## Authors

```
 @copyright : Ozvid Technologies Pvt. Ltd. < www.ozvid.com >
 @author     : Shiv Charan Panjeta < shiv@ozvid.com >
 All Rights Reserved.
 Proprietary and confidential :  All information contained herein is, and remains
 the property of Ozvid Technologies Pvt. Ltd. and its partners.
 Unauthorized copying of this file, via any medium is strictly prohibited.

```
