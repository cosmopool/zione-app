# Zione

:us: [English](README.md)

Zione foi feito para se ter uma única agenda com todos seus agendamentos.
Quando mais de uma pessoa realiza agendamentos,
fica claro a necessidade de uma agenda integrada para todos funcionários.

## Roadmap

Essa é a segunda versão do app. Você pode acessar a primeira [aqui](https://github.com/cosmopool/zione-app.old).
Essa versão foi reescrita seguindo as especificações da clean architecture
para melhorar a leitura e a manutenibilidade do código.

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

## Instruções

Esse é o front-end android da applicação. Para ter todo o ecosistema funcionando
é necessário ter a api instalanda e rodando __antes__ de usar o app.
Acesse as instruções do servidor da api [aqui](https://github.com/cosmopool/delforte-api).

#### Clone o repositório:
`git clone https://github.com/cosmopool/zione-app`

#### Baixe as dependências:
`flutter pub get`

#### Instale no android:
`flutter install`
