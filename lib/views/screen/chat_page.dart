import 'package:buddify/controller/geminicontroller.dart';
import 'package:buddify/controller/keyboardcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<GeminiController>(
                builder: (context, pro, _) {
                  return pro.gchats.isNotEmpty
                      ? ListView.builder(
                          reverse: true,
                          itemCount: pro.gchats.length,
                          itemBuilder: (context, index) {
                            var message = pro.gchats[index];

                            return Column(
                              crossAxisAlignment: message.sent.isEmpty
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                if (message.sent.isNotEmpty)
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                child: Text(
                                                  message.sent,
                                                  style: GoogleFonts.kodchasan(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff577FDF),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(16),
                                                      bottomLeft:
                                                          Radius.circular(16),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                      topLeft:
                                                          Radius.circular(16),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 2,
                                                        offset: Offset(0, 1),
                                                      )
                                                    ]),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                message.sent));
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    color: Colors.white,
                                                  )),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                if (message.recieved.isNotEmpty)
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.076,
                                          child: Lottie.network(
                                            'https://lottie.host/b15cb9e5-8e43-4390-815d-03727037680a/l6H48yj8Pw.json',
                                            animate: true,
                                            repeat: true,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.04,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                width: size.width * 0.65,
                                                child: Text(
                                                  message.recieved,
                                                  style: GoogleFonts.kodchasan(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff181818),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(16),
                                                      bottomLeft:
                                                          Radius.circular(16),
                                                      bottomRight:
                                                          Radius.circular(16),
                                                      topLeft:
                                                          Radius.circular(0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 2,
                                                        offset: Offset(0, 1),
                                                      )
                                                    ]),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Clipboard.setData(
                                                            ClipboardData(
                                                                text: message
                                                                    .recieved));
                                                      },
                                                      icon: Icon(
                                                        Icons.copy,
                                                        color: Colors.white,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        ShareExtend.share(
                                                            "Buddify:${message.recieved}",
                                                            'text');
                                                      },
                                                      icon: Icon(
                                                        CupertinoIcons.share,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Start Chatting With \n',
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
                        ));
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onFieldSubmitted: (val) {
                      Logger().w(val);
                      Provider.of<GeminiController>(context, listen: false)
                          .GeminiApi(val ?? '');
                      // controller.clear();
                    },
                    onChanged: (val) {
                      if (val.isEmpty) {
                        Provider.of<KeyboardController>(context, listen: false)
                            .toggleKeyboard(false);
                      } else {
                        Provider.of<KeyboardController>(context, listen: false)
                            .toggleKeyboard(true);
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
                      hintText: '\" Write Your Prompt Here \"',
                      hintStyle: GoogleFonts.kodchasan(
                        fontSize: 14,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Consumer2<KeyboardController, GeminiController>(
                    builder: (context, kay, gem, child) {
                  return gem.typing
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : IconButton(
                          onPressed: () {
                            if (kay.isKeyboardVisible) {
                              Provider.of<GeminiController>(context,
                                      listen: false)
                                  .GeminiApi(controller.text ?? '');

                              controller.clear();
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
                                ));
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
