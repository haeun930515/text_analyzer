import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KakaoShareProvider extends ChangeNotifier {
  FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '우리의 대화 분석 결과 공유',
      description: '우리의 대화 분석 결과가 나왔어요!',
      imageUrl: Uri.parse('https://example.com/image.jpg'),
      link: Link(
        androidExecutionParams: <String, String>{'key': 'value'},
        iosExecutionParams: <String, String>{'key': 'value'},
        mobileWebUrl: Uri.parse('https://example.com'),
        webUrl: Uri.parse('https://example.com'),
      ),
    ),
    buttons: [
      Button(
        title: '웹으로 보기',
        link: Link(
          androidExecutionParams: <String, String>{'key': 'value'},
          iosExecutionParams: <String, String>{'key': 'value'},
          mobileWebUrl: Uri.parse('https://example.com'),
          webUrl: Uri.parse('https://example.com'),
        ),
      ),
      Button(
        title: '앱으로 보기',
        link: Link(
          androidExecutionParams: <String, String>{'key': 'value'},
          iosExecutionParams: <String, String>{'key': 'value'},
          mobileWebUrl: Uri.parse('https://example.com'),
          webUrl: Uri.parse('https://example.com'),
        ),
      ),
    ],
  );

  kakaoShare(BuildContext context) async {
    // 카카오톡 친구 목록 가져오기
    Friends friends;
    try {
      friends = await TalkApi.instance.friends();
    } catch (error) {
      print('카카오톡 친구 목록 가져오기 실패 $error');
      // 메시지를 보낼 수 있는 친구 정보 가져오기에 실패한 경우에 대한 예외 처리 필요
      return;
    }

    if (friends.elements == null) {
      // 메시지를 보낼 수 있는 친구가 없는 경우에 대한 예외 처리 필요
      return;
    }

    if (friends.elements!.isEmpty) {
      print('메시지를 보낼 친구가 없습니다');
    } else {
      // 서비스에 상황에 맞게 메시지 보낼 친구의 UUID를 가져옵니다.
      // 이 예제에서는 친구 목록을 화면에 보여주고 체크박스로 선택된 친구들의 UUID를 수집하도록 구현했습니다.
      List<String> selectedItems = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FriendPage(
            items: friends.elements!
                .map((friend) => PickerItem(friend.uuid,
                    friend.profileNickname ?? '', friend.profileThumbnailImage))
                .toList(),
          ),
        ),
      );

      if (selectedItems.isEmpty) {
        // 메시지를 보낼 친구를 선택하지 않은 경우에 대한 예외 처리 필요
        return;
      }
      print('선택된 친구:\n${selectedItems.join('\n')}');

      // 메시지를 보낼 친구의 UUID 목록
      List<String> receiverUuids = selectedItems;

      // 피드 메시지, 메시지 만들기 참고
      FeedTemplate template = defaultFeed;

      // 기본 템플릿으로 메시지 보내기
      try {
        MessageSendResult result = await TalkApi.instance.sendDefaultMessage(
          receiverUuids: receiverUuids,
          template: template,
        );
        print('메시지 보내기 성공 ${result.successfulReceiverUuids}');

        if (result.failureInfos != null) {
          print('일부 대상에게 메시지 보내기 실패'
              '\n${result.failureInfos}');
        }
      } catch (error) {
        print('메시지 보내기 실패 $error');
      }
    }
  }
}

class FriendPage extends StatefulWidget {
  final List<PickerItem> items;

  const FriendPage({super.key, required this.items});

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구 선택'),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return CheckboxListTile(
            title: Text(item.nickname),
            subtitle: Text(item.uuid),
            value: selectedItems.contains(item.uuid),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedItems.add(item.uuid);
                } else {
                  selectedItems.remove(item.uuid);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.of(context).pop(selectedItems);
        },
      ),
    );
  }
}

class PickerItem {
  final String uuid;
  final String nickname;
  final String? profileImage;

  PickerItem(this.uuid, this.nickname, this.profileImage);
}

class KakaoShareButton extends StatelessWidget {
  final String text;

  const KakaoShareButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    KakaoShareProvider kakaoProvider =
        Provider.of<KakaoShareProvider>(context, listen: false);
    return InkWell(
      onTap: () => kakaoProvider.kakaoShare(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow, // 버튼의 배경색 설정
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black, // 버튼의 텍스트 색상 설정
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
