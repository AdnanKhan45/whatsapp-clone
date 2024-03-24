import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/features/app/const/page_const.dart';
import 'package:whatsapp_clone_app/features/app/global/widgets/show_image_and_video_widget.dart';
import 'package:whatsapp_clone_app/features/app/home/contacts_page.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';
import 'package:whatsapp_clone_app/features/call/presentation/cubits/my_call_history/my_call_history_cubit.dart';
import 'package:whatsapp_clone_app/features/call/presentation/pages/calls_history_page.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/pages/chat_page.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_image_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/usecases/get_my_status_future_usecase.dart';
import 'package:whatsapp_clone_app/features/status/presentation/cubit/status/status_cubit.dart';
import 'package:whatsapp_clone_app/features/status/presentation/pages/status_page.dart';
import 'package:whatsapp_clone_app/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp_clone_app/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsapp_clone_app/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:path/path.dart' as path;
import 'package:whatsapp_clone_app/storage/storage_provider.dart';
import 'package:whatsapp_clone_app/main_injection_container.dart' as di;

class HomePage extends StatefulWidget {
  final String uid;
  final int? index;

  const HomePage({super.key, required this.uid, this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    BlocProvider.of<MyCallHistoryCubit>(context).getMyCallHistory(uid: widget.uid);

    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 3, vsync: this);

    _tabController!.addListener(() {
      setState(() {
        _currentTabIndex = _tabController!.index;
      });
    });

    if (widget.index != null) {
      setState(() {
        _currentTabIndex = widget.index!;
        _tabController!.animateTo(1);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        BlocProvider.of<UserCubit>(context).updateUser(
            user: UserEntity(
                uid: widget.uid,
                isOnline: true
            )
        );
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        BlocProvider.of<UserCubit>(context).updateUser(
            user: UserEntity(
                uid: widget.uid,
                isOnline: false
            )
        );
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
        break;
    }
  }

  List<StatusImageEntity> _stories = [];


  List<File>? _selectedMedia;
  List<String>? _mediaTypes; // To store the type of each selected file

  Future<void> selectMedia() async {
    setState(() {
      _selectedMedia = null;
      _mediaTypes = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: true,
      );
      if (result != null) {
        _selectedMedia = result.files.map((file) => File(file.path!)).toList();

        // Initialize the media types list
        _mediaTypes = List<String>.filled(_selectedMedia!.length, '');

        // Determine the type of each selected file
        for (int i = 0; i < _selectedMedia!.length; i++) {
          String extension = path.extension(_selectedMedia![i].path)
              .toLowerCase();
          if (extension == '.jpg' || extension == '.jpeg' ||
              extension == '.png') {
            _mediaTypes![i] = 'image';
          } else if (extension == '.mp4' || extension == '.mov' ||
              extension == '.avi') {
            _mediaTypes![i] = 'video';
          }
        }

        setState(() {});
        print("mediaTypes = $_mediaTypes");
      } else {
        print("No file is selected.");
      }
    } catch (e) {
      print("Error while picking file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, state) {
        if(state is GetSingleUserLoaded) {
          final currentUser = state.singleUser;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "WhatsApp",
                style: TextStyle(
                    fontSize: 20,
                    color: greyColor,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                Row(
                  children: [
                    const Icon(
                      Icons.camera_alt_outlined,
                      color: greyColor,
                      size: 28,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Icon(Icons.search, color: greyColor, size: 28),
                    const SizedBox(
                      width: 10,
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: greyColor,
                        size: 28,
                      ),
                      color: appBarColor,
                      iconSize: 28,
                      onSelected: (value) {},
                      itemBuilder: (context) =>
                      <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: "Settings",
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageConst.settingsPage, arguments: widget.uid);
                              },
                              child: const Text('Settings')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              bottom: TabBar(
                labelColor: tabColor,
                unselectedLabelColor: greyColor,
                indicatorColor: tabColor,
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Text(
                      "Chats",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Status",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Calls",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],

              ),
            ),
            floatingActionButton: switchFloatingActionButtonOnTabIndex(
                _currentTabIndex, currentUser),
            body: TabBarView(
              controller: _tabController,

              children: [
                ChatPage(uid: widget.uid),
                StatusPage(currentUser: currentUser),
                CallHistoryPage(currentUser: currentUser,),
              ],
            ),
          );

        }
        return const Center(
          child: CircularProgressIndicator(
            color: tabColor,
          ),
        );
      },
    );
  }

  switchFloatingActionButtonOnTabIndex(int index, UserEntity currentUser) {
    switch (index) {
      case 0:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactsPage()));
              Navigator.pushNamed(context, PageConst.contactUsersPage, arguments: widget.uid);
            },
            child: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          );
        }
      case 1:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              selectMedia().then(
                    (value) {
                  if (_selectedMedia != null && _selectedMedia!.isNotEmpty) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: false,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return ShowMultiImageAndVideoPickedWidget(
                          selectedFiles: _selectedMedia!,
                          onTap: () {
                            _uploadImageStatus(currentUser);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                },
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          );
        }
      case 2:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              Navigator.pushNamed(context, PageConst.callContactsPage);
            },
            child: const Icon(
              Icons.add_call,
              color: Colors.white,
            ),
          );
        }
      default:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            child: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          );
        }
    }
  }

  _uploadImageStatus(UserEntity currentUser) {
    StorageProviderRemoteDataSource.uploadStatuses(
        files: _selectedMedia!,
        onComplete: (onCompleteStatusUpload) {}
    ).then((statusImageUrls) {
      for (var i = 0; i < statusImageUrls.length; i++) {
        _stories.add(StatusImageEntity(
          url: statusImageUrls[i],
          type: _mediaTypes![i],
          viewers: const [],
        ));
      }

      di.sl<GetMyStatusFutureUseCase>().call(widget.uid).then((myStatus) {
        if (myStatus.isNotEmpty) {
          BlocProvider.of<StatusCubit>(context).updateOnlyImageStatus(
              status: StatusEntity(
                  statusId: myStatus.first.statusId,
                  stories: _stories
              )
          ).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
                HomePage(uid: widget.uid, index: 1,)));
          });
        } else {
          BlocProvider.of<StatusCubit>(context).createStatus(
            status: StatusEntity(
                caption: "",
                createdAt: Timestamp.now(),
                stories: _stories,
                username: currentUser.username,
                uid: currentUser.uid,
                profileUrl: currentUser.profileUrl,
                imageUrl: statusImageUrls[0],
                phoneNumber: currentUser.phoneNumber
            ),
          ).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
                HomePage(uid: widget.uid, index: 1,)));
          });
        }
      });
    });
  }

}
