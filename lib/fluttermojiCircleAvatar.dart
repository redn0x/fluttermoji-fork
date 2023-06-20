import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './fluttermoji_assets/style.dart';
import 'fluttermoji_assets/fluttermojimodel.dart';
import 'fluttermoji_assets/clothes/clothes.dart';
import 'fluttermoji_assets/face/eyebrow/eyebrow.dart';
import 'fluttermoji_assets/face/eyes/eyes.dart';
import 'fluttermoji_assets/face/mouth/mouth.dart';
import 'fluttermoji_assets/face/nose/nose.dart';
import 'fluttermoji_assets/skin.dart';
import 'fluttermoji_assets/top/accessories/accessories.dart';
import 'fluttermoji_assets/top/facialHair/facialHair.dart';
import 'fluttermoji_assets/top/hairStyles/hairStyle.dart';

/// This widget renders the Fluttermoji of the user on screen
///
/// Accepts a [radius] which defaults to 75.0
/// and a [backgroundColor] which defaults to blueAccent
///
/// Advice the users to set up their Fluttermoji first to avoid unexpected issues.
class FluttermojiCircleAvatar extends StatelessWidget {
  FluttermojiCircleAvatar({
    super.key,
    this.radius = 75.0,
    this.backgroundColor,
    required this.options,
  });

  final double radius;
  final Color? backgroundColor;
  final Map<String, dynamic> options;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: SvgPicture.string(
        getFluttermojiFromOptions(),
        height: radius * 1.6,
        semanticsLabel: "Your Fluttermoji",
        placeholderBuilder: (context) => Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  String getFluttermojiFromOptions() {
    String _fluttermojiStyle =
        fluttermojiStyle[_getFluttermojiProperty('style')]!;
    String _clothe = Clothes.generateClothes(
        clotheType: _getFluttermojiProperty('clotheType'),
        clColor: _getFluttermojiProperty('clotheColor'))!;
    String _facialhair = FacialHair.generateFacialHair(
        facialHairType: _getFluttermojiProperty('facialHairType'),
        fhColor: _getFluttermojiProperty('facialHairColor'))!;
    String _mouth = mouth['${_getFluttermojiProperty('mouthType')}'];
    String _nose = nose['Default'];
    String _eyes = eyes['${_getFluttermojiProperty('eyeType')}'];
    String _eyebrows = eyebrow['${_getFluttermojiProperty('eyebrowType')}'];
    String _accessory = accessories[_getFluttermojiProperty('accessoriesType')];
    String _hair = HairStyle.generateHairStyle(
        hairType: _getFluttermojiProperty('topType'),
        hColor: _getFluttermojiProperty('hairColor'))!;
    String _skin = skin[_getFluttermojiProperty('skinColor')];
    String _completeSVG = '''
<svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink">
<desc>Fluttermoji on pub.dev</desc>
<defs>
<circle id="path-1" cx="120" cy="120" r="120"></circle>
<path d="M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z" id="path-3"></path>
<path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"></path>
</defs>
<g id="Fluttermoji" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
<g transform="translate(-825.000000, -1100.000000)" id="Fluttermoji/Circle">
<g transform="translate(825.000000, 1100.000000)">''' +
        _fluttermojiStyle +
        '''
<g id="Mask"></g>
<g id="Fluttermoji" stroke-width="1" fill-rule="evenodd">
<g id="Body" transform="translate(32.000000, 36.000000)">

<mask id="mask-6" fill="white">
<use xlink:href="#path-5"></use>
</mask>
<use fill="#D0C6AC" xlink:href="#path-5"></use>''' +
        _skin +
        '''<path d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z" id="Neck-Shadow" opacity="0.100000001" fill="#000000" mask="url(#mask-6)"></path></g>''' +
        _clothe +
        '''<g id="Face" transform="translate(76.000000, 82.000000)" fill="#000000">''' +
        _mouth +
        _facialhair +
        _nose +
        _eyes +
        _eyebrows +
        _accessory +
        '''</g>''' +
        _hair +
        '''</g></g></g></g></svg>''';
    return _completeSVG;
  }

  String _getFluttermojiProperty(String type) {
    return fluttermojiProperties[type]!
        .property!
        .elementAt(options[type] as int);
  }
}
