import 'dart:typed_data';
import 'package:get_it/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interesting_places/presentation/screens/add_new_place/bloc/add_new_place_bloc.dart';
import 'package:interesting_places/presentation/screens/add_new_place/widget/category_widget.dart';
import 'package:interesting_places/presentation/screens/add_new_place/widget/latitude_and_longitude_widget.dart';
import 'package:interesting_places/presentation/screens/add_new_place/widget/photo_widget.dart';
import 'package:interesting_places/presentation/screens/add_new_place/widget/point_to_map_widget.dart';
import 'package:interesting_places/presentation/screens/add_new_place/widget/text_field_widget.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_screen.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';
import 'package:interesting_places/presentation/widget/app_button_widget.dart';
import 'package:interesting_places/presentation/widget/indicator_widget.dart';
import 'package:interesting_places/repository/repository.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewPlaceScreen extends StatefulWidget {
  static const routeName = '/add_new_place';

  const AddNewPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  final ImageRepository repository = ImageRepository();
  final PageController controller = PageController();

  Future<Uint8List?> _showActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<Uint8List?>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              await repository.getFromGallery().then((value) => Navigator.of(context).pop(value));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImages.gallery,
                    height: 24,
                    width: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Фотография',
                      style: AppTextStyle.subtitle.copyWith(
                        color: AppColor.secondary2,
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
          child: Text(
            'ОТМЕНА',
            style: AppTextStyle.button.copyWith(
              color: AppColor.green,
            ),
          ),
        ),
      ),
    );
  }

  final _textLatitudeController = TextEditingController();
  final _textLongitudeController = TextEditingController();
  final _textNameController = TextEditingController();
  final _textDescriptionController = TextEditingController();

  @override
  void dispose() {
    _textLatitudeController.dispose();
    _textNameController.dispose();
    _textLongitudeController.dispose();
    _textDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetIt.I.get<AddNewPlaceBloc>()..add(LoadAddNewPlaceEvent()),
      child: BlocConsumer<AddNewPlaceBloc, AddNewPlaceState>(
        listener: (context, state) {
          if (state is AddNewPlaceInitialState) {
            _textLatitudeController.addListener(() {
              BlocProvider.of<AddNewPlaceBloc>(context).add(SaveLatitudeForNewPlaceEvent(_textLatitudeController.text));
            });
            _textNameController.addListener(() {
              BlocProvider.of<AddNewPlaceBloc>(context).add(SaveNameForNewPlaceEvent(_textNameController.text));
            });
            _textLongitudeController.addListener(() {
              BlocProvider.of<AddNewPlaceBloc>(context).add(SaveLongitudeForNewPlaceEvent(_textLongitudeController.text));
            });
            _textDescriptionController.addListener(() {
              BlocProvider.of<AddNewPlaceBloc>(context).add(SaveDescriptionForNewPlaceEvent(_textDescriptionController.text));
            });
          } else if (state is AddNewPlaceFinishState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PlaceListScreen(),
              ),
            );
          }
          ;
        },
        builder: (context, state) {
          switch (state) {
            case AddNewPlaceLoadingState() || AddNewPlaceInitialState():
              return const CircularProgressIndicatorWidget();
            case AddNewPlaceFailedState() || AddNewPlaceFinishState():
              return const CircularProgressIndicatorWidget();
            case AddNewPlaceSuccessState():
              _textLongitudeController.text = state.data.longitude;
              _textLatitudeController.text = state.data.latitude;
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                      'Новое место',
                      style: AppTextStyle.subtitle.copyWith(
                        color: AppColor.main,
                      ),
                    ),
                  ),
                  body: LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * .01),
                                SizedBox(
                                  height: 73,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.data.photo.length + 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      {
                                        if (index == 0) {
                                          return InkWell(
                                            onTap: () async {
                                              final res = await _showActionSheet(context);
                                              if (res != null && mounted) {
                                                BlocProvider.of<AddNewPlaceBloc>(context).add(
                                                  AddPhotoForNewPlaceEvent(res),
                                                );
                                              }
                                            },
                                            child: SizedBox(
                                              height: 72,
                                              width: 72,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: AppColor.green.withOpacity(0.48),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppColor.green,
                                                  size: 30.0,
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Text(
                                    'категория',
                                    style: AppTextStyle.superSmall.copyWith(
                                      color: AppColor.inactiveBlack,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => CategoryWidget(
                                          bloc: BlocProvider.of<AddNewPlaceBloc>(context),
                                          index: state.data.index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.data.index == -1 ? 'Не выбрано' : state.data.category,
                                          style: AppTextStyle.subtitle.copyWith(
                                            color: AppColor.secondary2,
                                          ),
                                        ),
                                        SvgPicture.asset(AppImages.view),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 0.3,
                                  width: double.infinity,
                                  color: AppColor.inactiveBlack,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12, top: 24),
                                  child: Text(
                                    'название',
                                    style: AppTextStyle.superSmall.copyWith(
                                      color: AppColor.inactiveBlack,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextFieldWidget(
                                    textController: _textNameController,
                                    screenText: state.data.name,
                                    color: AppColor.secondary.withOpacity(0.4),
                                    focusedColor: AppColor.green.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                LatitudeAndLongitudeWidget(
                                  textLatitudeController: _textLatitudeController,
                                  textLongitudeController: _textLongitudeController,
                                  longitude: state.data.longitude,
                                  latitude: state.data.latitude,
                                ),
                                const PointToMapWidget(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                    top: 24,
                                  ),
                                  child: Text(
                                    'описание',
                                    style: AppTextStyle.superSmall.copyWith(
                                      color: AppColor.inactiveBlack,
                                    ),
                                  ),
                                ),
                                TextFieldWidget(
                                  textController: _textDescriptionController,
                                  hintText: 'Text',
                                  minLines: 2,
                                  maxLines: 4,
                                  color: AppColor.inactiveBlack,
                                  focusedColor: AppColor.inactiveBlack,
                                  screenText: state.data.description,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: AppButtonWidget(
                                    title: 'создать',
                                    onPressed: () {
                                      BlocProvider.of<AddNewPlaceBloc>(context).add(CreateNewPlaceEvent());
                                    },
                                    isEnable: state.data.index != -1 &&
                                        state.data.latitude.isNotEmpty &&
                                        state.data.longitude.isNotEmpty &&
                                        state.data.name.isNotEmpty,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
          }
        },
      ),
    );
  }
}
