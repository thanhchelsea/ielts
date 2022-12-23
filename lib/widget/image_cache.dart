import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../values/app_images.dart';

class ImageCustom extends StatelessWidget {
  String url = "";
  double? width;
  double? height;
  bool isAvatar;
  double? radius;
  BoxShape? shape;
  ImageCustom({
    Key? key,
    this.url = "",
    this.width,
    this.height,
    this.isAvatar = false,
    this.radius,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: url.isNotEmpty
          ? CachedNetworkImage(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              width: width,
              height: height,
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                    height: width,
                    width: height,
                    decoration: BoxDecoration(
                      borderRadius: shape == null ? BorderRadius.all(Radius.circular(radius ?? 0)) : null,
                      shape: shape ?? BoxShape.rectangle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) => !isAvatar
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Image error!",
                          ),
                          const Icon(
                            Icons.error,
                          ),
                        ],
                      ),
                    )
                  : SvgPicture.asset(
                      AppImages.iconAvatarDefault,
                      color: Colors.white,
                    )
              //  : Image(image: AssetImage(AppImages.iconAvatarDefault)),
              )
          : SvgPicture.asset(
              AppImages.iconAvatarDefault,
              height: height,
              width: width,
              // color: Colors.white,
            ),
    );
  }
}
