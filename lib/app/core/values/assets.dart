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
    const Asset('Amazon', amazonPNG, 0),
    const Asset('Facebook', fbPNG, 1),
    const Asset('Flipkart', flipkartJPEG, 2),
    const Asset('Google', googlePNG, 3),
    const Asset('Instagram', instaJPEG, 4),
    const Asset('Microsoft', microsoftPNG, 5),
    const Asset('Qoura', qouraPNG, 6),
    const Asset('Snapchat', snapchatPNG, 7),
    const Asset('Twitter', twitterPNG, 8),
  ];

  static const logos = {
    'Amazon': Asset('amazon', amazonPNG, 0),
    'Facebook': Asset('fb', fbPNG, 1),
    'Flipkart': Asset('flipkart', flipkartJPEG, 2),
    'Google': Asset('google', googlePNG, 3),
    'Instagram': Asset('insta', instaJPEG, 4),
    'Microsoft': Asset('microsoft', microsoftPNG, 5),
    'Qoura': Asset('qoura', qouraPNG, 6),
    'Snapchat': Asset('snapchat', snapchatPNG, 7),
    'Twitter': Asset('twitter', twitterPNG, 8),
  };

  static bool isLogoExist(String image) {
    return logos.containsKey(image);
  }
}

class Asset {
  final String name;
  final String path;
  final int index;

  const Asset(this.name, this.path, this.index);
}
