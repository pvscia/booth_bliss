import 'package:booth_bliss/model/image_model.dart';
import 'package:booth_bliss/view/05_Profile_Page/view/profile_view.dart';
import 'package:booth_bliss/view/06_Detail_Page/controller/detail_controller.dart';
import 'package:booth_bliss/view/06_Detail_Page/view/use_frame_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import '../../Utils/view_dialog_util.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText({required this.text, this.maxLines = 2});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Split the text into words for hashtags
    List<String> words = widget.text.split(' ');

    // Display the text based on the expanded state
    String displayedText = _isExpanded
        ? widget.text
        : words.take(3).join(' '); // Show first 4 hashtags and "more"

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the text
        Flexible(
          child: Text(
            displayedText,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.034,
              color: Colors.black,
            ),
            // overflow: TextOverflow.visible,
          ),
        ),
        // Show "more" if not expanded
        if (!_isExpanded && words.length > 3)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = true; // Set to expanded
              });
            },
            child: Text(
              '... more',
              style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width * 0.034,
              ),
            ),
          ),
        // Show "less" if expanded
        if (_isExpanded)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = false; // Set to collapsed
              });
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                ' less',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.034,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

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
    email = FirebaseAuth.instance.currentUser ?.email ?? '';
    if (widget.imageData is ImageModel) {
      _isHeartPressed = widget.imageData.likedBy.where((test) {
        return test == email;
      }).isNotEmpty;
    }
    _fetchUserPhoto(); // Corrected method name
  }

  Future<void> _fetchUserPhoto() async {
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
                backgroundColor: Color(0xffffe5e5),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ensure Column takes only needed space
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
                                FontAwesomeIcons.chevronLeft,
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
                      Container(
                        // height: screenWidth ,
                        padding: EdgeInsets.symmetric(
                          vertical: 20, // Adjust vertical padding as needed
                          horizontal: 20,
                        ),
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
                                              ExpandableText(
                                                text: getCategoriesString(widget.imageData.categories),
                                                maxLines: 1, // Show 1 line initially for categories
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenWidth * 0.025),
                                    ExpandableText(
                                      text: widget.imageData.desc,
                                      maxLines: 2, // Show 2 lines initially
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
                                        Expanded(
                                          child: Center(
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
                                        ),
                                        // Icon(
                                        //   FontAwesomeIcons.shareFromSquare,
                                        //   color: Colors.black,
                                        //   size: screenWidth *
                                        //       0.08, // Reduce icon size
                                        // ),
                                      ],
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                    SizedBox(height: screenWidth * 0.15),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffb7ed9e),
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenWidth * 0.05,
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
                                  ],
                                  )
                                ),
                        ),
                      ),
                  ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator()), // Show loading indicator
      ),
    );
  }
}
