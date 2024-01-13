import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/features/app/const/page_const.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';
import 'package:whatsapp_clone_app/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone_app/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp_clone_app/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsapp_clone_app/features/user/presentation/cubit/user/user_cubit.dart';

import '../global/widgets/profile_widget.dart';

class ContactsPage extends StatefulWidget {
  final String uid;

  const ContactsPage({super.key, required this.uid});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {


  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contacts"),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if(state is GetSingleUserLoaded) {
            final currentUser = state.singleUser;

            return BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  final contacts = state.users.where((user) => user.uid != widget.uid).toList();


                  if (contacts.isEmpty) {
                    return const Center(
                      child: Text("No Contacts Yet"),
                    );
                  }

                  return ListView.builder(itemCount: contacts.length, itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.singleChatPage,
                            arguments: MessageEntity(
                              senderUid: currentUser.uid,
                              recipientUid: contact.uid,
                              senderName: currentUser.username,
                              recipientName: contact.username,
                              senderProfile: currentUser.profileUrl,
                              recipientProfile: contact.profileUrl,
                              uid: widget.uid
                            ));
                      },
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: profileWidget(imageUrl: contact.profileUrl)
                        ),
                      ),
                      title: Text("${contact.username}"),
                      subtitle: Text("${contact.status}"),
                    );
                  });
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: tabColor,
                  ),
                );

              },

            );

          }
          return const Center(
            child: CircularProgressIndicator(
              color: tabColor,
            ),
          );
        },
      ),
    );
  }
}

// FIXME: Logic to fetch contacts of the phone

// BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
// builder: (context, state) {
// if(state is GetDeviceNumberLoaded) {
// final contacts = state.contacts;
// return ListView.builder(itemCount: contacts.length, itemBuilder: (context, index) {
// final contact = contacts[index];
// return ListTile(
// leading: SizedBox(
// width: 50,
// height: 50,
// child: ClipRRect(
// borderRadius: BorderRadius.circular(25),
// child: Image.memory(
// contact.photo ?? Uint8List(0),
// errorBuilder: (context, error, stackTrace) {
// return Image.asset('assets/profile_default.png'); // Placeholder image
// },
// ),
//
// //profileWidget()
// ),
// ),
// title: Text("${contact.name!.first} ${contact.name!.last}"),
// subtitle: const Text("Hey there! I'm using WhatsApp"),
// );
// });
//
// }
// return const Center(
// child: CircularProgressIndicator(
// color: tabColor,
// ),
// );
// },
// ),
