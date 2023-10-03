import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interesting_places/screens/add_new_place/widget/photo_widget.dart';
import '../../widget/indicator_widget.dart';
import 'bloc/add_new_place_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewPlaceScreen extends StatefulWidget {
  static const routeName = '/intro';

  const AddNewPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  final PageController controller = PageController();
  var index = 0;
  Uint8List imageFile = Uint8List(0);

  Future<Uint8List?> _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      final uint8List = await pickedFile.readAsBytes();
      return uint8List;
    }
    return null;
  }

  Future<Uint8List?> _showActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<Uint8List?>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              await _getFromGallery().then((value) => Navigator.of(context).pop(value));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/gallery.svg',
                    height: 24,
                    width: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Фотография',
                      style: TextStyle(
                        color: Color(0xFF7C7E92),
                        fontSize: 20,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'ОТМЕНА',
            style: TextStyle(
              color: Color(0xFF4CAF50),
              fontSize: 14,
              height: 1.25,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddNewPlaceBloc()..add(LoadAddNewPlaceEvent()),
      child: BlocBuilder<AddNewPlaceBloc, AddNewPlaceState>(
        builder: (context, state) {
          if (state is AddNewPlaceLoadingState || state is AddNewPlaceInitialState) {
            return const CircularProgressIndicatorWidget();
          } else if (state is AddNewPlaceFailedState) {
            return const CircularProgressIndicatorWidget();
          } else if (state is AddNewPlaceSuccessState) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    'Новое место',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * .01),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.data.photo.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              {
                                if (index == 0) {
                                  return CupertinoPageScaffold(
                                    child: InkWell(
                                      onTap: () async {
                                        final res = await _showActionSheet(context);
                                        if (res != null && mounted) {
                                          BlocProvider.of<AddNewPlaceBloc>(context).add(
                                            AddPhotoForNewPlaceEvent(res),
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color(0xFF4CAF50).withOpacity(0.43),
                                            width: 3,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.green,
                                          size: 40.0,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return PhotoWidget(
                                    photo: state.data.photo[index - 1],
                                    bloc: BlocProvider.of<AddNewPlaceBloc>(context),
                                    index: index - 1,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
