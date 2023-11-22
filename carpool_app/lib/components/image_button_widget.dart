import 'package:flutter/material.dart';

class ImageButtonWidget extends StatelessWidget {
  final String imgUrl;
  final double size;
  final Function()? onTap;
  final ShapeType shape;
  final BorderRadiusGeometry? borderRadius;

  const ImageButtonWidget({
    Key? key,
    required this.imgUrl,
    required this.size,
    required this.shape,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: _buildDecoration(),
        child: _buildImage(),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      shape: shape == ShapeType.rectangle ? BoxShape.rectangle : BoxShape.circle,
    );
  }

  Widget _buildImage() {
    if (shape == ShapeType.circle) {
      return ClipOval(
        child: Image.asset(
          imgUrl,
          fit: BoxFit.cover,
        ),
      );
    } else if (shape == ShapeType.rectangle) {
      return Image.asset(
        imgUrl,
        fit: BoxFit.cover,
      );
    }
    return Container();
  }
}

enum ShapeType {
  rectangle,
  circle,
}
