# REAL8 Stellar Wallet

A comprehensive, production-ready cryptocurrency wallet for the Stellar network with advanced features, security, and analytics.

## 🌟 Features

### 🔐 Security Features
- **Multi-Factor Authentication**: PIN + Biometric authentication
- **Auto-Lock System**: Configurable timeout-based wallet locking
- **Encrypted Backups**: Password-protected wallet backup/restore
- **Session Management**: Automatic session validation and timeout
- **Security Levels**: Dynamic security assessment (Low/Medium/High)

### 💰 Core Wallet Features
- **Multi-Asset Support**: XLM, REAL8, and custom Stellar assets
- **Real-time Balances**: Live balance updates from Stellar network
- **Transaction Management**: Send, receive, and track transactions
- **QR Code Integration**: Scan and generate payment QR codes
- **Trustline Management**: Add/remove asset trustlines

### 📊 Analytics & Insights
- **Portfolio Dashboard**: Real-time portfolio value and performance
- **Transaction Analytics**: Detailed transaction insights and trends
- **Performance Metrics**: Return rates, best/worst performers
- **Interactive Charts**: Beautiful data visualization with fl_chart
- **Time Period Analysis**: 24h, 7d, 30d, 90d, 1y performance tracking

### 🔄 Advanced Trading
- **DEX Integration**: Full decentralized exchange support
- **Real-time Quotes**: Live swap pricing with slippage protection
- **Liquidity Pools**: Add/remove liquidity from pools
- **Swap History**: Complete trading history and analytics
- **Price Impact Analysis**: Transaction impact calculation

### 🔔 Smart Notifications
- **Transaction Alerts**: Real-time payment confirmations
- **Security Notifications**: PIN changes, biometric events
- **Price Alerts**: Customizable price threshold notifications
- **Backup Reminders**: Scheduled security reminders
- **Network Status**: Connection monitoring and alerts

### 🌍 Multi-Language Support
- **English & Spanish**: Full localization support
- **RTL Support**: Right-to-left language compatibility
- **Dynamic Language Switching**: Real-time language changes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.2.0 or higher
- Dart SDK 3.2.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/real8-stellar-wallet.git
   cd real8-stellar-wallet
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Edit environment variables
   nano .env
   ```

4. **Run the app**
   ```bash
   # For development
   flutter run
   
   # For production build
   flutter build apk --release
   ```

### Environment Configuration

Create a `.env` file with the following variables:

```env
# Stellar Network Configuration
STELLAR_NETWORK=public
STELLAR_HORIZON_URL=https://horizon.stellar.org

# REAL8 Asset Configuration
REAL8_ASSET_CODE=REAL8
REAL8_ASSET_ISSUER=GDUKMGUGDZQK6YHYA5Z6AY2G4XDSZPSZ3SW5UN3ARVMO6QSRDWP5YLEX

# API Keys (optional)
COINGECKO_API_KEY=your_coingecko_api_key
STELLAR_EXPERT_API_KEY=your_stellar_expert_api_key

# App Configuration
APP_NAME=REAL8 Wallet
APP_VERSION=1.0.0
```

## 📱 Usage Guide

### Creating a Wallet

1. **Launch the app** and tap "Create Wallet"
2. **Write down your mnemonic** phrase (12 words)
3. **Verify the mnemonic** by selecting words in order
4. **Set up security** (PIN, biometric authentication)
5. **Fund your wallet** with XLM for transaction fees

### Sending Payments

1. **Tap "Send"** from the wallet screen
2. **Enter recipient address** or scan QR code
3. **Select asset** and enter amount
4. **Add memo** (optional)
5. **Confirm transaction** and enter PIN/biometric

### Receiving Payments

1. **Tap "Receive"** from the wallet screen
2. **Share your address** or QR code
3. **Set payment amount** (optional)
4. **Wait for payment** confirmation

### Managing Assets

1. **Add Trustlines**: Go to Trustlines → Add Asset
2. **View Balances**: All assets displayed on wallet screen
3. **Swap Assets**: Use Swap feature for asset exchange
4. **Track Performance**: View analytics dashboard

### Security Settings

1. **Set PIN**: Settings → Security → Set PIN
2. **Enable Biometric**: Settings → Security → Biometric
3. **Configure Auto-Lock**: Settings → Security → Auto-Lock
4. **Create Backup**: Settings → Backup → Create Backup

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── l10n/                     # Localization files
├── src/
│   ├── data/                 # Data layer
│   │   ├── local/           # Local storage & services
│   │   ├── remote/          # API services
│   │   └── repository/      # Repository pattern
│   ├── domain/              # Business logic layer
│   │   ├── model/           # Domain models
│   │   └── usecase/         # Use cases
│   ├── presentation/        # UI layer
│   │   ├── navigation/      # Routing
│   │   ├── screens/         # UI screens
│   │   ├── widgets/         # Reusable widgets
│   │   └── bloc/            # State management
│   └── util/                # Utilities & constants
```

### Key Technologies

- **Flutter**: Cross-platform UI framework
- **BLoC**: State management pattern
- **Go Router**: Navigation and routing
- **Stellar SDK**: Blockchain integration
- **Secure Storage**: Encrypted local storage
- **Local Auth**: Biometric authentication
- **QR Code**: Payment QR generation/scanning
- **Charts**: Data visualization
- **Notifications**: Local notification system

## 🔧 Development

### Code Style
- Follow Flutter/Dart style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Write unit tests for business logic

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Building for Production

#### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

#### iOS
```bash
# Build for iOS
flutter build ios --release
```

#### Web
```bash
# Build for web
flutter build web --release
```

## 🔒 Security Considerations

### Private Key Management
- Private keys are never stored in plain text
- All sensitive data is encrypted using Flutter Secure Storage
- Biometric authentication adds an extra security layer
- Auto-lock prevents unauthorized access

### Network Security
- All API calls use HTTPS
- Certificate pinning for critical endpoints
- Request/response validation
- Rate limiting for API calls

### Backup Security
- Backup files are encrypted with user password
- Checksum validation ensures file integrity
- Secure sharing mechanisms
- Backup history tracking

## 📊 Performance Optimization

### Caching Strategy
- Memory cache for frequently accessed data
- Persistent cache for important data
- Automatic cache expiration
- Background cache cleanup

### API Optimization
- Request batching for multiple API calls
- Response caching to reduce network calls
- Background data synchronization
- Offline mode support

### Memory Management
- Automatic memory cleanup
- Widget optimization
- Image caching and compression
- Background task management

## 🚀 Deployment

### Release Process
1. **Version Update**: Update version in `pubspec.yaml`
2. **Testing**: Run comprehensive test suite
3. **Build**: Create production builds
4. **Signing**: Sign APK/IPA with release keys
5. **Distribution**: Upload to app stores

### App Store Guidelines
- Follow platform-specific guidelines
- Provide clear app descriptions
- Include privacy policy
- Test on multiple devices
- Prepare store screenshots

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Submit a pull request

### Code Review Process
- All changes require code review
- Tests must pass before merging
- Follow established coding standards
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Documentation
- [API Documentation](docs/api.md)
- [Architecture Guide](docs/architecture.md)
- [Security Guide](docs/security.md)
- [Deployment Guide](docs/deployment.md)

### Community
- [Discord Server](https://discord.gg/9YTMedEy7M)
- [Telegram Group](https://t.me/real8_coin)
- [GitHub Issues](https://github.com/REAL8-crypto/real8-stellar-wallet/issues)

### Contact
- **Email**: soporte@real8.com
- **Website**: https://real8.org
- **Twitter**: [@real8Coin](https://twitter.com/Real8Coin)

## 🙏 Acknowledgments

- Stellar Development Foundation for the Stellar network
- Flutter team for the amazing framework
- All contributors and community members
- Open source projects that made this possible

---

**⚠️ Disclaimer**: This wallet is for educational and development purposes. Always test with small amounts and ensure you understand the risks involved with cryptocurrency transactions.
