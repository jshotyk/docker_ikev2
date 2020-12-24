# IKEv2 VPN Server on Docker with auto server ip detect

Recipe to build [`vl_burtsev/ikev2-vpn-alpine`](https://registry.hub.docker.com/u/vl_burtsev/ikev2-vpn-alpine/) Docker image. 
Fork from [`nebukad/ikev2-vpn-alpine`](https://registry.hub.docker.com/u/nebukad/ikev2-vpn-alpine/)
Fork from [`gaomd/ikev2-vpn-server`](https://hub.docker.com/r/gaomd/ikev2-vpn-server/)

## Usage

### 1. Clone this repository

    git clone https://github.com/VictorBurtsev/ikev2-vpn-server.git && cd ikev2-vpn-server && git checkout alpine-3.12

### 2. Build docker image

    docker build --no-cache -t ikev2-vpn-server:alpine .

### 3. Start the IKEv2 VPN Server

    docker run --cap-add=NET_ADMIN -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp ikev2-vpn-server:alpine

### 4. Generate the .mobileconfig (for iOS / macOS) to the current path

    docker exec -it ikev2-vpn-server generate-mobileconfig > ikev2-vpn.mobileconfig

Transfer the generated `ikev2-vpn.mobileconfig` file to your local computer via SSH tunnel (`scp`) or any other secure methods.

### 5. Install the .mobileconfig (for iOS / macOS)

- **iOS 9 or later**: AirDrop the `.mobileconfig` file to your iOS 9 device, finish the **Install Profile** screen;

- **macOS 10.11 El Capitan or later**: Double click the `.mobileconfig` file to start the *profile installation* wizard.

## Technical Details

Upon container creation, a *shared secret* was generated for authentication purpose, no *certificate*, *username*, or *password* was ever used, simple life!

## License

Copyright (c) 2018 Mengdi Gao, Nebukad93, vl_burtsev  This software is licensed under the [MIT License](LICENSE).

---

\* IKEv2 protocol requires iOS 8 or later, macOS 10.11 El Capitan or later.

\* Install for **iOS 8 or later** or when your AirDrop fails: Send an E-mail to your iOS device with the `.mobileconfig` file as attachment, then tap the attachment to bring up and finish the **Install Profile** screen.
