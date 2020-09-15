import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWishlistToggle extends StatefulWidget {
  CartWishlistToggle({@required this.courseId});

  final String courseId;

  @override
  _CartWishlistToggleState createState() => _CartWishlistToggleState();
}

class _CartWishlistToggleState extends State<CartWishlistToggle> {
  bool isLoading = false;
  bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    isFavorite = user.wishlist.contains(widget.courseId);
    if (user.cart == null) user.cart = [];

    return Stack(
      children: [
        Container(
          height: Provider.of<DeviceDimension>(context).height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: user.myCourses.contains(widget.courseId)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  user.myCourses.contains(widget.courseId)
                      ? SizedBox.shrink()
                      : RaisedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (user.cart.contains(widget.courseId)) {
                              await UserController.removeFromCart(
                                userId: user.userId,
                                courseId: widget.courseId,
                              );
                              Provider.of<User>(context, listen: false)
                                  .removeCourseFromCart(widget.courseId);
                              Navigator.pop(context);
                            } else {
                              await UserController.addToCart(
                                userId: user.userId,
                                courseId: widget.courseId,
                              );
                              Provider.of<User>(context, listen: false)
                                  .addCourseToCart(widget.courseId);
                              Navigator.pop(context);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            user.cart.contains(widget.courseId)
                                ? "Remove from cart"
                                : "Add to cart",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white),
                          ),
                        ),
                  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      if (isFavorite) {
                        await UserController.removeFromWishlist(
                          userId: user.userId,
                          courseId: widget.courseId,
                        );
                        Provider.of<User>(context, listen: false)
                            .removeCourseFromWishlist(widget.courseId);
                        Navigator.pop(context);
                      } else {
                        await UserController.addToWishlist(
                          userId: user.userId,
                          courseId: widget.courseId,
                        );
                        Provider.of<User>(context, listen: false)
                            .addCourseToWishlist(widget.courseId);
                        Navigator.pop(context);
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Text(
                      isFavorite ? "Remove from wishlist" : "Add to Wishlist",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox.shrink()
      ],
    );
  }
}
