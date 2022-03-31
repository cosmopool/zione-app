[![codecov](https://codecov.io/gh/cosmopool/zione-app/branch/master/graph/badge.svg?token=OPP05SDPRL)](https://codecov.io/gh/cosmopool/zione-app)

# Zione

:globe_with_meridians: [Português-Brasil](README-BR.md)

Zione was made to provide a single source of truth for your appointments and tickets.
When more than one person book appointments,
it is clear the need of a integrated agenda for all employees.

## Roadmap

This is the second version of the app. You can access the old one [here](https://github.com/cosmopool/zione-app.old).
This version is written following the clean architecture specs to improve
code readability and maintainability.

| __v.0.6.0__ | __v1.0.0__ |
|---|---|
| :heavy_check_mark: Agenda Feed | :white_check_mark: Insert Appointments when offline |
| :heavy_check_mark: Tickets Feed | :white_check_mark: Insert Tickets when offline |
| :heavy_check_mark: Agenda Feed Cache | :white_check_mark: Appointment time availability|
| :heavy_check_mark: Tickets Feed Cache | :white_check_mark: Address Geocoding |
| :white_check_mark: Add Appointments | :white_check_mark: Push Notification |
| :white_check_mark: Edit Appointments | :white_check_mark: Only one expanded card at once |
| :heavy_check_mark: Close Appointments | :white_check_mark: Swipe down to refresh |
| :heavy_check_mark: Delete Appointments | :white_check_mark: Appointment time notification |
| :white_check_mark: Add Tickets | :white_check_mark: Calculate travel time between appointments |
| :white_check_mark: Edit Tickets | :white_check_mark: Cache Entries edit when offline |
| :heavy_check_mark: Close Tickets | :white_check_mark: Cache Settings |
| :heavy_check_mark: Delete Tickets |  |
| :white_check_mark: Settings Page |  |
| :white_check_mark: Login Page |  |

## Instructions

This is the front-end android application. To a fully working environment,
you will need the api up and running __before__ use the app.
Access the api instructions [here](https://github.com/cosmopool/delforte-api).

#### Clone this repo:
`git clone https://github.com/cosmopool/zione-app`

#### Download dependencies:
`flutter pub get`

#### Install on android:
`flutter install`
