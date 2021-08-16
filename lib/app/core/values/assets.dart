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
    const Asset('Facebook', fbPNG),
    const Asset('Flipkart', flipkartJPEG),
    const Asset('Google', googlePNG),
    const Asset('Instagram', instaJPEG),
    const Asset('Microsoft', microsoftPNG),
    const Asset('Qoura', qouraPNG),
    const Asset('Snapchat', snapchatPNG),
    const Asset('Twitter', twitterPNG),
  ];

  static const logos = {
    'Amazon': Asset('amazon', amazonPNG),
    'Facebook': Asset('fb', fbPNG),
    'Flipkart': Asset('flipkart', flipkartJPEG),
    'Google': Asset('google', googlePNG),
    'Instagram': Asset('insta', instaJPEG),
    'Microsoft': Asset('microsoft', microsoftPNG),
    'Qoura': Asset('qoura', qouraPNG),
    'Snapchat': Asset('snapchat', snapchatPNG),
    'Twitter': Asset('twitter', twitterPNG),
  };

  static bool isLogoExist(String image) {
    return logos.containsKey(image);
  }
}

class Asset {
  final String name;
  final String path;

  const Asset(this.name, this.path);
}
