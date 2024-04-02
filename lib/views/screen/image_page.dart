import 'dart:io';
import 'dart:typed_data';

import 'package:buddify/controller/imagecontroller.dart';
import 'package:buddify/controller/keyboardcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

class ImagePage extends StatelessWidget {
  ImagePage({super.key});
  TextEditingController imcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ImageController, KeyboardController>(
          builder: (context, pro, kay, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pro.image.isNotEmpty)
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.memory(
                                    pro.image,
                                    fit: BoxFit.cover,
                                  )),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final tempDir = await getTemporaryDirectory();
                                  final file = File(
                                      '${tempDir.path}/captured_image.png');
                                  await file
                                      .writeAsBytes(pro.image ?? Uint8List(0));
                                  await ShareExtend.share(file.path, "image");
                                },
                                icon: Icon(CupertinoIcons.share,
                                    color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                  ))
            else
              Expanded(
                flex: 8,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Say Hi To Your Creativity With \n',
                          style: GoogleFonts.kodchasan(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'Buddify !!',
                          style: GoogleFonts.kodchasan(
                            color: Color(0xff57cfdf),
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: imcontroller,
                        onFieldSubmitted: (val) async {
                          Logger().w(val);
                          pro.ImaginApi(val);

                          imcontroller.clear();
                        },
                        onChanged: (val) {
                          if (val.isEmpty) {
                            kay.toggleKeyboard(false);
                          } else {
                            kay.toggleKeyboard(true);
                          }
                        },
                        style: GoogleFonts.kodchasan(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xff181818),
                          contentPadding: EdgeInsets.all(16),
                          suffixIcon: Icon(CupertinoIcons.search),
                          suffixIconColor: Colors.white.withOpacity(0.8),
                          hintText: '\" Write Your Imagination Here \"',
                          hintStyle: GoogleFonts.kodchasan(
                            fontSize: 14,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        )),
                  ),
                  pro.typing
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : IconButton(
                          onPressed: () {
                            if (kay.isKeyboardVisible) {
                              pro.ImaginApi(imcontroller.text);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Please Enter Something'),
                              ));
                            }
                          },
                          icon: kay.isKeyboardVisible
                              ? Icon(
                                  Icons.telegram,
                                  size: 40,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.telegram,
                                  size: 40,
                                  color: Colors.grey,
                                ))
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
