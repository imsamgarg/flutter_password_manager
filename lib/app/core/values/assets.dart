class AssetsLogos {
  static const amazonPNG = 'assets/logos/amazon.png';
  static const fbPNG = 'assets/logos/fb.png';
  static const flipkartJPEG = 'assets/logos/flipkart.jpeg';
  static const googlePNG = 'assets/logos/google.png';
  static const instaJPEG = 'assets/logos/insta.jpeg';
  static const microsoftPNG = 'assets/logos/microsoft.png';
  static const qouraPNG = 'assets/logos/qoura.png';
  static const snapchatPNG = 'assets/logos/snapchat.png';
  static const twitterPNG = 'assets/logos/twitter.png';

  static const logoList = [
    const Asset('Amazon', amazonPNG),
    const Asset('Faceboot', fbPNG),
    const Asset('Flipkart', flipkartJPEG),
    const Asset('Google', googlePNG),
    const Asset('Instagram', instaJPEG),
    const Asset('Microsoft', microsoftPNG),
    const Asset('Qoura', qouraPNG),
    const Asset('Snapchat', snapchatPNG),
    const Asset('Twitter', twitterPNG),
  ];

  static const logos = {
    'amazon': Asset('amazon', amazonPNG),
    'fb': Asset('fb', fbPNG),
    'flipkart': Asset('flipkart', flipkartJPEG),
    'google': Asset('google', googlePNG),
    'insta': Asset('insta', instaJPEG),
    'microsoft': Asset('microsoft', microsoftPNG),
    'qoura': Asset('qoura', qouraPNG),
    'snapchat': Asset('snapchat', snapchatPNG),
    'twitter': Asset('twitter', twitterPNG),
  };

  bool isLogoExist(String image) {
    return logos.containsKey(image);
  }
}

class Asset {
  final String name;
  final String path;

  const Asset(this.name, this.path);
}
