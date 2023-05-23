import 'package:flutter/material.dart';
import 'package:text_analyzer/model/score_model.dart';

class ResultProvider with ChangeNotifier {
  var _photo1 = "assets/images/resultDogsWithBody/dalma.png";
  var _photo2 = "assets/images/resultDogsWithBody/dalma.png";
  var _title = "";
  var _sub = "";

  var picBishon = "assets/images/resultDogsWithBody/bis.png";
  var picChew = "assets/images/resultDogsWithBody/chew.png";
  var picChiwawa = "assets/images/resultDogsWithBody/chi.png";
  var picColy = "assets/images/resultDogsWithBody/col.png";
  var picDalma = "assets/images/resultDogsWithBody/dalma.png";
  var picHound = "assets/images/resultDogsWithBody/houn.png";
  var picLit = "assets/images/resultDogsWithBody/lit.png";
  var picMal = "assets/images/resultDogsWithBody/mal.png";
  var picPome = "assets/images/resultDogsWithBody/pome.png";
  var picPood = "assets/images/resultDogsWithBody/pood.png";
  var picShap = "assets/images/resultDogsWithBody/shap.png";
  var picYork = "assets/images/resultDogsWithBody/york.png";

  String get photo1 => _photo1;
  String get photo2 => _photo2;
  String get title => _title;
  String get sub => _sub;

  var angerNum = 0;
  var happyNum = 0;
  var curNum = 0;
  var anxNum = 0;
  var vigNum = 0;

  getNum(ScoreModel sc) {
    if (1 <= sc.happiness && sc.happiness <= 2) {
      happyNum = 1;
    } else if (3 <= sc.happiness && sc.happiness <= 5) {
      happyNum = 2;
    }

    if (1 <= sc.curiosity && sc.curiosity <= 2) {
      curNum = 1;
    } else if (3 <= sc.curiosity && sc.curiosity <= 5) {
      curNum = 2;
    }

    if (1 <= sc.vigilance && sc.vigilance <= 3) {
      vigNum = 1;
    } else if (4 <= sc.vigilance && sc.vigilance <= 5) {
      vigNum = 2;
    }

    if (1 <= sc.anger && sc.anger <= 3) {
      angerNum = 1;
    } else if (4 <= sc.anger && sc.anger <= 5) {
      angerNum = 2;
    }

    if (1 <= sc.anxiety && sc.anxiety <= 3) {
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
      _photo1 = picDalma;
      _photo2 = picPood;
      _title = "달마시안 vs 푸들";
      _sub = "서로에게 관심이 부족합니다. 눈이라도 마주쳐 보세요";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //2
      //시츄 , 비숑 - 불안해 할 필요 없어요.

      _photo1 = picChew;
      _photo2 = picBishon;
      _title = "보더콜리 / 치와와";
      _sub = "보더콜리는 활동적이고 치와와는 작은 체구를 가지고 있으므로, 보더콜리가 치와와를 쫓아갈 가능성이 있습니다.";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //3
      //비숑, 치와와 - 항상 조금씩 화나 있습니다

      _photo1 = picBishon;
      _photo2 = picChiwawa;
      _title = "비숑프리제 vs 달마시안";
      _sub =
          "달마시안의 활동성과 경계심은 비숑을 겁나게 할 수 있고, 비숑의 작은 크기는 달마시안이 너무 격렬하게 다가갈 수 있는 가능성이 있습니다";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //4
      //비숑, 요크셔 테리어 - 항상 조금씩 화나있고, 불안해 하고 있어요

      _photo1 = picBishon;
      _photo2 = picYork;
      _title = "비숑프리제 vs 요크셔테리어";
      _sub = "항상 조금씩 화나있고, 불안해 하고 있어요.";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //5
      //하운드, 셰퍼드 - 경계심을 풀고 조금 더 다가가 보세요

      _photo1 = picHound;
      _photo2 = picShap;
      _title = "하운드 vs 져먼셰퍼드";
      _sub = "경계심을 풀고 조금 더 다가가 보세요.";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //6
      //하운드, 셰퍼드 - 불안해 하지말고 경계를 풀고 조금 더 다가가 보세요

      _photo1 = picHound;
      _photo2 = picShap;
      _title = "하운드 vs 져먼셰퍼드";
      _sub = "불안해 하지말고 경계를 풀고 조금 더 다가가 보세요.";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //7
      //셰퍼드, 리트리버 - 경계와 분노를 풀고 조금 더 다가가 보세요

      _photo1 = picShap;
      _photo2 = picLit;
      _title = "져먼셰퍼드 vs 리트리버";
      _sub = "경계와 분노를 풀고 조금 더 다가가 보세요.";
    } else if (happyNum == 1 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //8
      //하운드, 요크셔테리어 - 경계, 분노, 불안이 가득. 뭔가 마음에 안드는 상대네요.

      _photo1 = picHound;
      _photo2 = picYork;
      _title = "하운드 vs 요크셔테리어";
      _sub = "경계, 분노, 불안이 가득. 뭔가 마음에 안드는 상대네요.";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //9
      //몰티즈, 포메라니안 - 산책할때 자주 보던 바로 그 조합

      _photo1 = picMal;
      _photo2 = picPome;
      _title = "말티즈 vs 포메라니안";
      _sub = "산책할때 자주 보던 바로 그 조합";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //10
      //몰티즈, 요크셔테리어 - 서로에 대한 호감또한 있지만, 불안해 하네요

      _photo1 = picMal;
      _photo2 = picYork;
      _title = "말티즈 vs 요크셔테리어";
      _sub = "서로에 대한 호감 또한 있지만, 불안해 하네요";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //11
      //요크셔테리어, 치와와 - 서로의 호감도 있지만, 분노가 가득하기도 합니다.

      _photo1 = picYork;
      _photo2 = picChiwawa;
      _title = "요크셔테리어 vs 치와와";
      _sub = "서로의 호감도 있지만, 분노가 가득하기도 합니다.";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //12
      //비숑, 포메라니안 - 서로를 향해 너무 달려들지만 마세요.

      _photo1 = picBishon;
      _photo2 = picPome;
      _title = "비숑프리제 vs 포메라니안";
      _sub = "서로를 향해 너무 달려들지만 마세요.";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //13
      //보더콜리, 셰퍼드 - 서로가 궁금하지만, 그만큼 경계하고 있네요

      _photo1 = picColy;
      _photo2 = picShap;
      _title = "보더콜리 vs 져먼셰퍼드";
      _sub = "서로가 궁금하지만, 그만큼 경계하고 있네요.";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //14
      //시추, 몰티즈 - 서로가 궁금하기도하지만 불안함과 함께 경계하고 있네요

      _photo1 = picChew;
      _photo2 = picMal;
      _title = "보더콜리 vs 져먼셰퍼드";
      _sub = "서로가 궁금하기도 하지만 불안함과 함께 경계하고 있네요.";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //15
      //포메라니안, 치와와 - 궁금하다고 너무 달려들지 마세요

      _photo1 = picPome;
      _photo2 = picChiwawa;
      _title = "포메라니안 vs 치와와";
      _sub = "궁금하다고 너무 달려들지 마세요.";
    } else if (happyNum == 1 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //16
      //요크셔테리어, 시추 - 서로를 향해 달려들긴 하지만 딱히 좋아서 그런건 아니에요

      _photo1 = picYork;
      _photo2 = picChew;
      _title = "요크셔테리어 vs 시츄";
      _sub = "서로를 향해 달려들긴 하지만 딱히 좋아서 그런건 아니에요.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //17
      //몰티즈, 포메라니안 - 너무 좋기만 한데요?

      _photo1 = picYork;
      _photo2 = picPood;
      _title = "요크셔테리어  -  푸들";
      _sub =
          "일반적으로 말하면 서로 어울릴 수 있습니다. 작은 크기와 비슷한 활동 수준을 가지고 있기 때문에 서로 놀고 뛰며 재미있게 시간을 보낼 수 있습니다.푸들은 훈련하기 쉬우며, 지능적이므로 요크셔 테리어와 함께 훈련하고 활동하는 것을 즐길 수 있습니다. 함께 트릭을 배우거나 놀이를 즐기며 서로를 자극할 수 있습니다.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //18
      //포메라니안, 요크셔테리어 - 서로 너무 좋죠.하지만 불안한건 당신들만이 아닐지도

      _photo1 = picPome;
      _photo2 = picYork;
      _title = "포메라니안 vs 요크셔테리어";
      _sub = "서로 너무 좋죠. 하지만 불안한건 당신들만이 아닐지도.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //19
      //몰티즈, 치와와 - 좋았다가 안좋았다가 기분이 오락가락 하네요

      _photo1 = picMal;
      _photo2 = picChiwawa;
      _title = "말티즈 vs 치와와";
      _sub = "좋았다가 안좋았다가 기분이 오락가락 하네요.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //20
      //몰티즈, 요크셔테리어 - 싸우지 말고 친하게 지내요

      _photo1 = picMal;
      _photo2 = picYork;
      _title = "말티즈 vs 요크셔테리어";
      _sub = "싸우지 말고 친하게 지내요.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //21
      //리트리버, 보더콜리 - 경계를 조금만 풀면 친한 친구가 될거에요

      _photo1 = picLit;
      _photo2 = picColy;
      _title = "리트리버 vs 보더콜리";
      _sub = "경계를 조금만 풀면 친한 친구가 될거에요.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //22
      //리트리버, 하운드 - 경계를 조금만 풀면 친한 친구가 될거에요

      _photo1 = picLit;
      _photo2 = picHound;
      _title = "리트리버 vs 하운드";
      _sub = "경계를 조금만 풀면 친한 친구가 될거에요.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //23
      //치와와, 몰티즈 - 싸우지말고 마음을 열면 좋은 친구가 될지도 몰라요

      _photo1 = picChiwawa;
      _photo2 = picMal;
      _title = "치와와 vs 말티즈";
      _sub = "싸우지말고 마음을 열면 좋은 친구가 될지도 몰라요.";
    } else if (happyNum == 2 &&
        curNum == 1 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //24
      //하운드, 셰퍼드 - 서로를 인정하고 마음을 열면 좋은 친구가 될거에요

      _photo1 = picHound;
      _photo2 = picShap;
      _title = "하운드 vs 져먼셰퍼드";
      _sub = "서로를 인정하고 마음을 열면 좋은 친구가 될거에요.";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 1) {
      //25
      //시추, 리트리버 - 이미 서로 좋은 친구가 아닐까요?

      _photo1 = picChew;
      _photo2 = picLit;
      _title = "시츄 vs 리트리버";
      _sub = "이미 서로 좋은 친구가 아닐까요?";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 1 &&
        anxNum == 2) {
      //26
      //시추, 보더콜리 - 조금만 노력하면 서로 좋은 친구가 되어 줄거에요

      _photo1 = picChew;
      _photo2 = picColy;
      _title = "시츄 vs 보더콜리";
      _sub = "조금만 노력하면 서로 좋은 친구가 되어 줄거에요";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 1) {
      //27
      //치와와, 시추 - 분노만 조금 가라앉히고 다시 얘기를 해봐요

      _photo1 = picChiwawa;
      _photo2 = picChew;
      _title = "치와와 vs 시츄";
      _sub = "분노를 조금 가라앉히고 다시 얘기를 해봐요";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 1 &&
        angerNum == 2 &&
        anxNum == 2) {
      //28
      //푸들, 비숑 - 지금도 좋지만 서로 약간의 경계는 두는게 좋을지도 몰라요

      _photo1 = picPood;
      _photo2 = picBishon;
      _title = "푸들 vs 비숑프리제";
      _sub = "지금도 좋지만 서로 약간의 경계는 두는게 좋을지도 몰라요";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 1) {
      //29
      //푸들, 시추 - 딱히 문제가 생길거 같지 않아요

      _photo1 = picPood;
      _photo2 = picChew;
      _title = "푸들 vs 시츄";
      _sub = "딱히 문제가 생길거 같지 않아요";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 1 &&
        anxNum == 2) {
      //30
      //시추, 달마시안 - 가끔 화를 내도 괜찮은 사이에요

      _photo1 = picChew;
      _photo2 = picDalma;
      _title = "시츄 vs 달마시안";
      _sub = "가끔 화를 내도 괜찮은 사이에요";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 1) {
      //31
      //리트리버, 몰티즈 - 가끔 화도 내지만, 절친한 친구에요.

      _photo1 = picLit;
      _photo2 = picMal;
      _title = "리트리버 vs 말티즈";
      _sub = "가끔 화도 내지만, 절친한 친구에요.";
    } else if (happyNum == 2 &&
        curNum == 2 &&
        vigNum == 2 &&
        angerNum == 2 &&
        anxNum == 2) {
      //32
      //포메라니안, 몰티즈, 요크셔테리어 - 이 조합은 온갖 감정이 요동치네요

      _photo1 = picPome;
      _photo2 = picMal;
      _title = "포메라니안 vs 말티즈";
      _sub = "온갖 감정이 요동치네요";
    }
    notifyListeners();
  }
}
