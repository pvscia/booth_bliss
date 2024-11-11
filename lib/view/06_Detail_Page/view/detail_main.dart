import 'package:booth_bliss/model/image_model.dart';
import 'package:booth_bliss/view/05_Profile_Page/view/profile_view.dart';
import 'package:booth_bliss/view/06_Detail_Page/controller/detail_controller.dart';
import 'package:booth_bliss/view/06_Detail_Page/view/use_frame_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import '../../Utils/view_dialog_util.dart';

class DetailPage extends StatefulWidget {
  final dynamic imageData;

  DetailPage({required this.imageData});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  bool _isHeartPressed = false;
  String profileUrl = '';
  bool isLoading = true; // Start loading as true
  late String email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser?.email ?? '';
    if (widget.imageData is ImageModel) {
      _isHeartPressed = widget.imageData.likedBy.where((test) {
        return test == email;
      }).isNotEmpty;
    }
    _fetchUserPhoto(); // Corrected method name
  }

  Future<void> _fetchUserPhoto() async {
    // Corrected method name
    try {
      String? fetchedUrl =
          await DetailController().fetchProfilePhoto(widget.imageData.user.uid);
      setState(() {
        profileUrl = fetchedUrl ?? ''; // Handle potential null
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching photo: $e');
      setState(() {
        profileUrl = ''; // Reset profile URL on error
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String getCategoriesString(List<String> categories) {
      return categories.map((category) => '#$category').join(' ');
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        if (widget.imageData is ImageModel) {
          Navigator.pop(context, widget.imageData);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        child: !isLoading
            ? Scaffold(
                backgroundColor: Colors.grey[100],
                body: Column(
                  children: [
                    // Image Section with icons
                    Stack(
                      children: [
                        Image.network(
                          widget.imageData.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (widget.imageData is ImageModel) {
                                Navigator.pop(context, widget.imageData);
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // Profile and Buttons Section
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 15, left: 20, right: 20),
                        color: Color(0xffffe5e5),
                        child: Center(
                          child: widget.imageData is ImageModel
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: screenWidth * 0.07,
                                          backgroundImage: profileUrl.isNotEmpty
                                              ? NetworkImage(profileUrl)
                                              : AssetImage(
                                                      'assets/default-user.png')
                                                  as ImageProvider,
                                        ),
                                        SizedBox(width: screenWidth * 0.03),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileView(
                                                        user: widget
                                                            .imageData.user,
                                                        viewOnly: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  '${widget.imageData.user.firstName} ${widget.imageData.user.lastName}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth * 0.05,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 1),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  getCategoriesString(widget
                                                      .imageData.categories),
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                  ),
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenWidth * 0.025),
                                    Text(
                                      widget.imageData.desc,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.034,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: screenWidth * 0.025),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            ViewDialogUtil()
                                                .showLoadingDialog(context);
                                            _isHeartPressed
                                                ? await DetailController()
                                                    .unlikeFrame(
                                                    widget.imageData.docName,
                                                    email,
                                                  )
                                                : await DetailController()
                                                    .likeFrame(
                                                    widget.imageData.docName,
                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.email ??
                                                        '',
                                                  );
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Navigator.of(context).pop();
                                            });
                                            setState(() {
                                              _isHeartPressed =
                                                  !_isHeartPressed;
                                              if (_isHeartPressed) {
                                                widget.imageData.likedBy
                                                    .add(email);
                                              } else {
                                                widget.imageData.likedBy
                                                    .remove(email);
                                              }
                                            });
                                          },
                                          child: Icon(
                                            _isHeartPressed
                                                ? FontAwesomeIcons.solidHeart
                                                : FontAwesomeIcons.heart,
                                            color: Colors.red,
                                            size: screenWidth *
                                                0.08, // Reduce icon size
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xffb7ed9e),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: screenWidth * 0.03,
                                                  horizontal:
                                                      screenWidth * 0.1),
                                              // Adjust padding
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                side: BorderSide(
                                                  color: Color(0xff50c400),
                                                  width: screenWidth * 0.008,
                                                ),
                                              ),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                'Use Frame',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.045,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UseFrameView(
                                                    filename: widget
                                                        .imageData.filename,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.shareFromSquare,
                                          color: Colors.black,
                                          size: screenWidth *
                                              0.08, // Reduce icon size
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffb7ed9e),
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenWidth * 0.03,
                                          horizontal: screenWidth * 0.15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(
                                          color: Color(0xff50c400),
                                          width: screenWidth * 0.008,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Save to Library',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () async {
                                      ViewDialogUtil()
                                          .showLoadingDialog(context);
                                      await DetailController()
                                          .downloadAndSaveImage(
                                              widget.imageData.imageUrl,
                                              widget.imageData.filename);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.of(context).pop();
                                        ViewDialogUtil()
                                            .showOneButtonActionDialog(
                                                'Photo Saved',
                                                'Ok',
                                                'success.gif',
                                                context,
                                                () {});
                                      });
                                    },
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator()), // Show loading indicator
      ),
    );
  }
}
