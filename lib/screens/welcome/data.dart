// ignore: unused_import
import 'package:flutter/material.dart';

class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath!;
  }

  String getTitle() {
    return title!;
  }

  String getDesc() {
    return desc!;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = [];
  // ignore: unnecessary_new
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Meningkatkan value didalam diri dengan mentor yang tepat.");
  sliderModel.setTitle("Bertumbuh");
  sliderModel.setImageAssetPath("assets/img/welcome/welcome_1.png");
  slides.add(sliderModel);

  // ignore: unnecessary_new
  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Membangun dan mengscale out bisnis secara kolaboratif.");
  sliderModel.setTitle("Berjejaring");
  sliderModel.setImageAssetPath("assets/img/welcome/welcome_2.png");
  slides.add(sliderModel);

  // ignore: unnecessary_new
  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Sinergi untuk membangun kekuatan ekonomi yang baik.");
  sliderModel.setTitle("Berdaya");
  sliderModel.setImageAssetPath("assets/img/welcome/welcome_3.png");
  slides.add(sliderModel);

  // ignore: unnecessary_new
  sliderModel = new SliderModel();

  return slides;
}
