# OpenWRT-Based Travel Router for Raspberry Pi CM4

<p align="center">
  <img src="image.png " alt="Travel Router" width="500" />
</p>

## Introduction

This project presents a custom OpenWRT-based travel router built on the Raspberry Pi Compute Module 4 (CM4) platform, utilizing the Waveshare CM4-DUAL-ETH-MINI board. It is designed to provide reliable and secure internet connectivity for professionals and enthusiasts who require consistent network access while traveling.

## Usage

> [!WARNING]
> The firmware is customized for specific hardware configuration. If you have a different configuration, you may need to build the firmware yourself.

## Hardware Specifications

### Raspberry Pi Compute Module 4

- **Processor:** Broadcom BCM2711 quad-core Cortex-A72 (ARM v8) 64-bit SoC @ 1.5GHz
- **Memory:** 2GB, 4GB, or 8GB LPDDR4-3200 SDRAM (depending on model)
- **Storage:** 8GB, 16GB, or 32GB eMMC Flash (depending on model)
- **Wireless:** 2.4GHz and 5.0GHz IEEE 802.11b/g/n/ac wireless, Bluetooth 5.0, BLE
- **Video & Audio:** 2 × 4K HDMI, 2 × MIPI DSI display, 2 × MIPI CSI-2 camera

### Waveshare CM4-DUAL-ETH-MINI Board

- Dual Gigabit Ethernet ports
- 1x USB 3.0 Type-A port
- 1x Micro-SD card slot
- 1x USB 2.0 pin header
- 1x 12V DC power input
- Supports CM4 and CM4Lite modules
- Compact size: 85mm x 56mm

## Key Features

### Advanced Networking Capabilities

1. **Multi-WAN Support:** Facilitates seamless switching between various internet sources.
2. **VPN Integration:** Includes support for OpenVPN and WireGuard, ensuring secure and private connections.
3. **Tethering Compatibility:** Supports multiple tethering options for use with mobile devices.
4. **Extensive WiFi Adapter Support:** Accommodates a wide range of WiFi adapters for optimal connectivity.

### User-Centric Software Features

1. **Intuitive Web Interface:** Offers a modern, user-friendly interface for effortless network management.
2. **Smart Network Management:**
  - Bandwidth monitoring
  - WiFi scheduling
  - System temperature monitoring
3. **File Sharing Capabilities:** Incorporates Samba for convenient file sharing within the network.

### Security and Performance Optimization

1. **Firewall Configuration:** Ensures network security through robust firewall settings.
2. **Quality of Service (QoS):** Implements Smart Queue Management for optimized network performance.
3. **DNS over HTTPS:** Provides enhanced privacy for DNS queries.

## Ideal Use Cases

This travel router is particularly well-suited for:

- Business professionals requiring reliable internet access during travel
- Remote workers needing secure connections in various locations
- Individuals seeking to enhance their home network with advanced features
- Travelers desiring consistent internet access in diverse environments

## Software Package Highlights

- **Base System:** OpenWRT with LuCI web interface
- **Network Management:** Multi-WAN support, QoS, firewall configuration
- **VPN:** OpenVPN, WireGuard
- **DNS:** HTTPS DNS proxy
- **Modem Support:** QMI and MBIM protocols for cellular modems
- **WiFi:** Support for various USB WiFi adapters
- **Monitoring:** Bandwidth, system statistics, and thermal monitoring
- **File Sharing:** Samba module

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.
