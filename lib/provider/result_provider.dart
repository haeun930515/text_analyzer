import 'package:flutter/material.dart';
import 'package:text_analyzer/model/score_model.dart';
import 'package:text_analyzer/utils/strings.dart';

class ResultProvider with ChangeNotifier {
  var _photo1 = "assets/images/resultDogsWithBody/dalma.png";
  var _photo2 = "assets/images/resultDogsWithBody/dalma.png";
  var _title = "";
  var _main = "";
  var _sub = "";

  String get photo1 => _photo1;
  String get photo2 => _photo2;
  String get title => _title;
  String get sub => _sub;
  String get main => _main;

  var angerNum = 0;
  var happyNum = 0;
  var curNum = 0;
  var anxNum = 0;
  var vigNum = 0;

  getNum(ScoreModel sc) {
    if (0 <= sc.happiness && sc.happiness <= 2) {
      happyNum = 1;
    } else if (3 <= sc.happiness && sc.happiness <= 5) {
      happyNum = 2;
    }

    if (0 <= sc.curiosity && sc.curiosity <= 2) {
      curNum = 1;
    } else if (3 <= sc.curiosity && sc.curiosity <= 5) {
      curNum = 2;
    }

    if (0 <= sc.vigilance && sc.vigilance <= 3) {
      vigNum = 1;
    } else if (4 <= sc.vigilance && sc.vigilance <= 5) {
      vigNum = 2;
    }

    if (0 <= sc.anger && sc.anger <= 3) {
      angerNum = 1;
    } else if (4 <= sc.anger && sc.anger <= 5) {
      angerNum = 2;
    }

    if (0 <= sc.anxiety && sc.anxiety <= 3) {
      anxNum = 1;
    } else if (4 <= sc.anxiety && sc.anxiety <= 5) {
      anxNum = 2;
    }
  }

  getResult(ScoreModel scoreModel) {
    getNum(scoreModel);
    if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //1
      //달마시안 , 푸들 - 서로에게 관심이 부족합니다. 눈이라도 마주쳐 보세요
      _photo1 = Strings.picHound;
      _photo2 = Strings.picChew;
      _title = Strings.case11111title;
      _sub = Strings.case11111sub;
      _main = Strings.case11111main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //2
      //시츄 , 비숑 - 불안해 할 필요 없어요.

      _photo1 = Strings.picColy;
      _photo2 = Strings.picChiwawa;

      _title = Strings.case11112title;
      _sub = Strings.case11112sub;
      _main = Strings.case11112main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //3
      //비숑, 치와와 - 항상 조금씩 화나 있습니다

      _photo1 = Strings.picBishon;
      _photo2 = Strings.picDalma;

      _title = Strings.case11121title;
      _sub = Strings.case11121sub;
      _main = Strings.case11121main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //4
      //비숑, 요크셔 테리어 - 항상 조금씩 화나있고, 불안해 하고 있어요

      _photo1 = Strings.picShap;
      _photo2 = Strings.picPome;

      _title = Strings.case11122title;
      _sub = Strings.case11122sub;
      _main = Strings.case11122main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //5
      //하운드, 셰퍼드 - 경계심을 풀고 조금 더 다가가 보세요

      _photo1 = Strings.picHound;
      _photo2 = Strings.picPood;

      _title = Strings.case11211title;
      _sub = Strings.case11211sub;
      _main = Strings.case11211main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //6
      //하운드, 셰퍼드 - 불안해 하지말고 경계를 풀고 조금 더 다가가 보세요

      _photo1 = Strings.picChiwawa;
      _photo2 = Strings.picPood;

      _title = Strings.case11212title;
      _sub = Strings.case11212sub;
      _main = Strings.case11212main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //7
      //셰퍼드, 리트리버 - 경계와 분노를 풀고 조금 더 다가가 보세요

      _photo1 = Strings.picChew;
      _photo2 = Strings.picPome;

      _title = Strings.case11221title;
      _sub = Strings.case11221sub;
      _main = Strings.case11221main;
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //8
      //하운드, 요크셔테리어 - 경계, 분노, 불안이 가득. 뭔가 마음에 안드는 상대네요.

      _photo1 = Strings.picChiwawa;
      _photo2 = Strings.picYork;

      _title = Strings.case11222title;
      _sub = Strings.case11222sub;
      _main = Strings.case11222main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //9
      //몰티즈, 포메라니안 - 산책할때 자주 보던 바로 그 조합

      _photo1 = Strings.picMal;
      _photo2 = Strings.picPome;

      _title = Strings.case12111title;
      _sub = Strings.case12111sub;
      _main = Strings.case12111main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //10
      //몰티즈, 요크셔테리어 - 서로에 대한 호감또한 있지만, 불안해 하네요

      _photo1 = Strings.picHound;
      _photo2 = Strings.picMal;

      _title = Strings.case12112title;
      _sub = Strings.case12112sub;
      _main = Strings.case12112main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //11
      //요크셔테리어, 치와와 - 서로의 호감도 있지만, 분노가 가득하기도 합니다.

      _photo1 = Strings.picYork;
      _photo2 = Strings.picPome;

      _title = Strings.case12121title;
      _sub = Strings.case12121sub;
      _main = Strings.case12121main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //12
      //비숑, 포메라니안 - 서로를 향해 너무 달려들지만 마세요.

      _photo1 = Strings.picDalma;
      _photo2 = Strings.picColy;

      _title = Strings.case12122title;
      _sub = Strings.case12122sub;
      _main = Strings.case12122main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //13
      //보더콜리, 셰퍼드 - 서로가 궁금하지만, 그만큼 경계하고 있네요

      _photo1 = Strings.picChew;
      _photo2 = Strings.picLit;

      _title = Strings.case12211title;
      _sub = Strings.case12211sub;
      _main = Strings.case12211main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //14
      //시추, 몰티즈 - 서로가 궁금하기도하지만 불안함과 함께 경계하고 있네요

      _photo1 = Strings.picLit;
      _photo2 = Strings.picChiwawa;

      _title = Strings.case12212title;
      _sub = Strings.case12212sub;
      _main = Strings.case12212main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //15
      //포메라니안, 치와와 - 궁금하다고 너무 달려들지 마세요

      _photo1 = Strings.picChew;
      _photo2 = Strings.picShap;

      _title = Strings.case12221title;
      _sub = Strings.case12221sub;
      _main = Strings.case12221main;
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //16
      //요크셔테리어, 시추 - 서로를 향해 달려들긴 하지만 딱히 좋아서 그런건 아니에요

      _photo1 = Strings.picDalma;
      _photo2 = Strings.picColy;

      _title = Strings.case12222title;
      _sub = Strings.case12222sub;
      _main = Strings.case12222main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //17
      //몰티즈, 포메라니안 - 너무 좋기만 한데요?

      _photo1 = Strings.picShap;
      _photo2 = Strings.picPood;

      _title = Strings.case21111title;
      _sub = Strings.case21111sub;
      _main = Strings.case21111main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //18
      //포메라니안, 요크셔테리어 - 서로 너무 좋죠.하지만 불안한건 당신들만이 아닐지도

      _photo1 = Strings.picYork;
      _photo2 = Strings.picPood;

      _title = Strings.case21112title;
      _sub = Strings.case21112sub;
      _main = Strings.case21112main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //19
      //몰티즈, 치와와 - 좋았다가 안좋았다가 기분이 오락가락 하네요

      _photo1 = Strings.picYork;
      _photo2 = Strings.picDalma;

      _title = Strings.case21121title;
      _sub = Strings.case21121sub;
      _main = Strings.case21121main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //20
      //몰티즈, 요크셔테리어 - 싸우지 말고 친하게 지내요

      _photo1 = Strings.picShap;
      _photo2 = Strings.picYork;

      _title = Strings.case21122title;
      _sub = Strings.case21122sub;
      _main = Strings.case21122main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //21
      //리트리버, 보더콜리 - 경계를 조금만 풀면 친한 친구가 될거에요

      _photo1 = Strings.picShap;
      _photo2 = Strings.picColy;

      _title = Strings.case21211title;
      _sub = Strings.case21211sub;
      _main = Strings.case21211main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //22
      //리트리버, 하운드 - 경계를 조금만 풀면 친한 친구가 될거에요

      _photo1 = Strings.picLit;
      _photo2 = Strings.picChiwawa;

      _title = Strings.case21212title;
      _sub = Strings.case21212sub;
      _main = Strings.case21212main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //23
      //치와와, 몰티즈 - 싸우지말고 마음을 열면 좋은 친구가 될지도 몰라요

      _photo1 = Strings.picChiwawa;
      _photo2 = Strings.picPome;

      _title = Strings.case21221title;
      _sub = Strings.case21221sub;
      _main = Strings.case21221main;
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //24
      //하운드, 셰퍼드 - 서로를 인정하고 마음을 열면 좋은 친구가 될거에요

      _photo1 = Strings.picYork;
      _photo2 = Strings.picLit;

      _title = Strings.case21222title;
      _sub = Strings.case21222sub;
      _main = Strings.case21222main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //25
      //시추, 리트리버 - 이미 서로 좋은 친구가 아닐까요?

      _photo1 = Strings.picMal;
      _photo2 = Strings.picPood;

      _title = Strings.case22111title;
      _sub = Strings.case22111sub;
      _main = Strings.case22111main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //26
      //시추, 보더콜리 - 조금만 노력하면 서로 좋은 친구가 되어 줄거에요

      _photo1 = Strings.picLit;
      _photo2 = Strings.picColy;

      _title = Strings.case22112title;
      _sub = Strings.case22112sub;
      _main = Strings.case22112main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //27
      //치와와, 시추 - 분노만 조금 가라앉히고 다시 얘기를 해봐요

      _photo1 = Strings.picMal;
      _photo2 = Strings.picYork;

      _title = Strings.case22121title;
      _sub = Strings.case22121sub;
      _main = Strings.case22121main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //28
      //푸들, 비숑 - 지금도 좋지만 서로 약간의 경계는 두는게 좋을지도 몰라요

      _photo1 = Strings.picDalma;
      _photo2 = Strings.picLit;

      _title = Strings.case22122title;
      _sub = Strings.case22122sub;
      _main = Strings.case22122main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //29
      //푸들, 시추 - 딱히 문제가 생길거 같지 않아요

      _photo1 = Strings.picLit;
      _photo2 = Strings.picMal;

      _title = Strings.case22211title;
      _sub = Strings.case22211sub;
      _main = Strings.case22211main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //30
      //시추, 달마시안 - 가끔 화를 내도 괜찮은 사이에요

      _photo1 = Strings.picPood;
      _photo2 = Strings.picLit;

      _title = Strings.case22212title;
      _sub = Strings.case22212sub;
      _main = Strings.case22212main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //31
      //리트리버, 몰티즈 - 가끔 화도 내지만, 절친한 친구에요.

      _photo1 = Strings.picDalma;
      _photo2 = Strings.picMal;

      _title = Strings.case22221title;
      _sub = Strings.case22221sub;
      _main = Strings.case22221main;
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //32
      //포메라니안, 몰티즈, 요크셔테리어 - 이 조합은 온갖 감정이 요동치네요

      _photo1 = Strings.picShap;
      _photo2 = Strings.picLit;

      _title = Strings.case22222title;
      _sub = Strings.case22222sub;
      _main = Strings.case22222main;
    }
    notifyListeners();
  }
}
