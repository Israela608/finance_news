import 'dart:async';
import 'dart:convert';

import 'package:finance_news/data/models/news.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NewsWebSocketService {
  final String url;
  late WebSocketChannel _channel;

  NewsWebSocketService(this.url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }
  // NewsWebSocketService(String url)
  //     : _channel = WebSocketChannel.connect(Uri.parse(url));

  Stream<List<News>> get newsStream {
    return _channel.stream.map((event) {
      final data = jsonDecode(event);
      // Assume the API sends a list of news. Adjust as needed.
      return News.fromListJson(data['news']);
    });
  }

  /// Sends a message to request a specific page
  void requestPage(int page) {
    final message = jsonEncode({'type': 'get_news', 'page': page});
    _channel.sink.add(message);
  }

  /// Receives the paginated news list
  /* Stream<List<News>> get newsStream {
    return _channel.stream.map((event) {
      final data = jsonDecode(event);
      return News.fromListJson(data['news']);
    });
  }*/

  void close() {
    _channel.sink.close();
  }

  ChatNotifier chatNotifier;

  late PusherChannelsFlutter _pusher;
  late PusherChannel _chatChannel;
  late PusherChannel _chatRoomChannel;
  //late String _chatRoomId;

  void initialize() {
    state = PatientChatState();
  }

  set chatRoomStatus(ChatRoomStatus value) =>
      state = state.copyWith(status: value);

  Future<void> requestChat() async {
    initialize();
    state = state.setLoading('');
    final response = await chatNotifier.requestChat();
    if (response.isSuccess) {
      state = state.copyWith(chat: response.data);
      await connectToPusher();
    } else
      state = state.copyWith(response: response);
  }

  // Get the Updated Chatroom if you have joined a chat
  Future<ApiResponse<Chat>> getUpdatedChat() async {
    state = state.setLoading('');
    final response = await chatNotifier.getUpdatedPatientChat();
    state = state.copyWith(
      response: response,
      chat: response.data,
    );
    // if (response.isSuccess) chatRoomStatus = ChatRoomStatus.ongoing;
    return response;
  }

  Future<ApiResponse<List<Message>>> getMessages() async {
    final response =
        await chatNotifier.getMessages(chatRoomId: state.chat.id ?? '');
    state = state.copyWith(
      response: response,
      messages: response.data,
    );

    // Assign duration to all the audio messages
    for (int i = 0; i < state.messages.length; i++) {
      Message message = state.messages[i];

      getAudioDuration(message).then((duration) {
        if (duration != null) {
          setAudioDuration(message.messageId ?? '', duration);
        }
      });
    }

    return response;
  }

  set showExtendSessionDialog(bool value) =>
      state = state.copyWith(showExtendSessionDialog: value);

  Future<void> connectToPusher({bool reenteringChat = false}) async {
    _pusher = PusherChannelsFlutter.getInstance();

    try {
      await _pusher.init(
        apiKey: ApiConstants.API_KEY,
        cluster: ApiConstants.CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onPusherError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
      );

      _chatChannel = await _pusher.subscribe(
        channelName: state.chat.channelId ?? '',
        //channelName: _chatChanelName,
        onEvent: onChatEvent,
        onSubscriptionSucceeded: onChatSubscriptionSucceeded,
        onSubscriptionError: onChatSubscriptionError,
      );

      _chatRoomChannel = await _pusher.subscribe(
        channelName: ApiConstants.CHATROOM_CHANNEL,
        onEvent: onChatRoomEvent,
        //onSubscriptionSucceeded: onChatRoomSubscriptionSucceeded,
        onSubscriptionError: onChatRoomSubscriptionError,
      );

      await _pusher.connect();

      debugPrint('Connect to Pusher Successfully');
      if (reenteringChat) chatRoomStatus = ChatRoomStatus.ongoing;

      // _startReconnectTimer();

      state = state.copyWith(
          response: ApiResponse.success('Successfully Created Chatroom'));
    } catch (e) {
      debugPrint("PUSHER ERROR: $e");
      chatRoomStatus = ChatRoomStatus.initial;
      state = state.copyWith(response: ApiResponse.error(e.toString()));
      _stopReconnectTimer();
    }
  }

  Timer? _reconnectTimer;
  bool _isReconnecting = false;

  Future<void> reconnectPusher() async {
    if (_isReconnecting) return;

    _isReconnecting = true;
    try {
      debugPrint(
          'Reconnecting Pusher................................................');
      debugPrint('Chat Status => ${state.status}');
      debugPrint('Pusher State => ${_pusher.connectionState}');
      if (state.status == ChatRoomStatus.ongoing &&
          _pusher.connectionState != ApiConstants.pusherConnected &&
          _pusher.connectionState != ApiConstants.pusherConnecting) {
        await _pusher.connect();
      }
      // await _pusher.disconnect();
    } catch (e) {
      debugPrint("PUSHER XX ERROR: $e");
      state = state.copyWith(response: ApiResponse.error(e.toString()));
    }
    _isReconnecting = false;
  }

  void _stopReconnectTimer() {
    _reconnectTimer?.cancel();
  }

  // Called when a event is received by the client.
  // The global event handler will trigger on events from any channel.
  void onEvent(PusherEvent event) {
    //log("onEvent: $event");
  }

  // Declare a variable to store the last extend chat timestamp
  DateTime? _lastExtendChatTime;

  // Receive Message
  onChatEvent(event) async {
    debugPrint("Message received: $event");

    final String eventName = event.eventName;

    late var eventData;

    try {
      debugPrint('EVENT DATA => ${event.data}');
      eventData = json.decode(event.data!);
    } catch (e) {
      debugPrint('Exception => $e');
      // If there is not data, stop the method
      return;
    }

    /*
      NEW MESSAGE EVENT
   */
    if (eventName == ApiConstants.NEW_MESSAGE_EVENT) {
      debugPrint('NEW MESSAGE..........................');

      final message = Message.fromJson(eventData);
      logMessage(message);

      if (message.room == state.chat.id) {
        debugPrint('Message id for this room');
        // Only add messages of the other user and not messages of the sender
        if (message.sender != state.chat.patient?.lastName) {
          debugPrint('DISPLAYING MESSAGE');
          await addMessage(message);
          // Update Delivery Status of the Other user
          await chatNotifier.updateDeliveryStatus(
            messageId: message.messageId ?? '',
          );
        }
      } else {
        debugPrint(
            'This message belongs to another Chatroom of this same Client');
      }
    }

    /*
      UPDATE MESSAGE EVENT
   */
    else if (eventName == ApiConstants.UPDATE_MESSAGE_EVENT) {
      debugPrint('MESSAGE UPDATE..........................');

      final message = Message.fromJson(eventData);

      logMessage(message, isUpdated: true);

      if (message.room == state.chat.id) {
        debugPrint('Message id for this room');
        // Only update messages of the other user and not messages of the sender
        debugPrint('UPDATING MESSAGE');

        // Message Id must not be null.
        // If any other of the message parameter received is null, then the value remains the same as it was previously
        updateMessage(
          messageId: message.messageId ?? '',
          content: message.content,
          isDelivered: message.isDelivered,
          isRead: message.isRead,
        );
      } else {
        debugPrint(
            'This message belongs to another Chatroom of this same Client');
      }
    }

    /*
      UPDATE OTHER USER CHAT INTERACTION
   */
    else if (eventName == ApiConstants.NEW_INTERACTION) {
      // log('INTERACTION UPDATE..........................');

      if (eventData['room'] == state.chat.id) {
        // The Other user is the Pharmacist
        if (eventData['sender'] == state.chat.pharmacist?.lastName) {
          //  log('Interaction is for this room');
          // Only update messages of the other user and not messages of the sender
          debugPrint(
              'UPDATING PATIENT OTHER USER INTERACTION..........................................');

          _updateOtherUserInteraction(
            isOnline: eventData['online'],
            isTyping: eventData['is_typing'],
            isRecording: eventData['is_recording'],
          );
        }
      } else {
        debugPrint(
            'This interaction belongs to another Chatroom of this same Client');
      }
    }

    /*
      NOTIFICATION EVENTS
   */
    else {
      String eventChatRoomId = eventData['chatroom_id'] ?? '';
      debugPrint('EVENT CHATROOM ID ---->   $eventChatRoomId');
      debugPrint('EVENT CHATROOMXX ID ---->   ${state.chat.id}');

      if (eventChatRoomId == state.chat.id) {
        final String eventName = event.eventName;
        debugPrint('EVENT NAME --->  $eventName');

        /*
        PHARMACIST JOINED CHATROOM EVENT
      */

        if (eventName == ApiConstants.PHARM_JOINED_CHATROOM_EVENT) {
          // Get the updated chat
          final response = await getUpdatedChat();
          if (response.isSuccess) chatRoomStatus = ChatRoomStatus.ongoing;
        }

        /*
        PHARMACIST CLOSED CHATROOM EVENT
      */
        else if (eventName == ApiConstants.PHARM_CLOSED_CHATROOM_EVENT) {
          try {
            await _pusher.disconnect();
            await _pusher.unsubscribe(channelName: state.chat.channelId ?? '');
            await _pusher.unsubscribe(
                channelName: ApiConstants.CHATROOM_CHANNEL);
            _stopReconnectTimer();
          } catch (e) {
            debugPrint("PUSHER ERROR: $e");
            debugPrint("Error Closing Event: $e");
          }

          chatRoomStatus = ChatRoomStatus.completed;
          debugPrint('Chatroom Session Ended by Pharmacist');
        }

        /*
        EXTEND CHAT
      */
        else if (eventName == ApiConstants.EXTEND_CHAT) {
          // showExtendSessionDialog = true;

          final now = DateTime.now();

          // Check if the last extend chat time was more than 5 minutes ago
          if (_lastExtendChatTime == null ||
              now.difference(_lastExtendChatTime!).inMinutes >= 5) {
            _lastExtendChatTime = now; // Update timestamp

            showExtendSessionDialog = true;
            debugPrint('Extend chat dialog triggered');
          } else {
            debugPrint(
                'Extend chat ignored - waiting 5 minutes before triggering again');
          }
        }
      } else {
        debugPrint('UNKNOWN or USELESS EVENT');
      }
    }
  }

  @override
  void dispose() {
    // Dispose timers when the notifier is destroyed
    _onlineTimer?.cancel();
    _typingTimer?.cancel();
    _stopReconnectTimer();
    super.dispose();
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("Connection: $currentState");

    // This prevents getting the messages when initialing reentering chat
    // Only get the messages when pusher was disconnected and now connected in an already active chatroom
    if (state.status == ChatRoomStatus.ongoing &&
        currentState == ApiConstants.pusherConnected) {
      getMessages();
    }

    if (currentState == 'CONNECTING')
      state.copyWith(
          myChatRoomConnectionStatus: MyChatRoomConnectionStatus.connecting);
    else if (currentState == 'RECONNECTING')
      state.copyWith(
          myChatRoomConnectionStatus: MyChatRoomConnectionStatus.reconnecting);
    else if (currentState == 'CONNECTED')
      state.copyWith(
          myChatRoomConnectionStatus: MyChatRoomConnectionStatus.connected);
    else
      state.copyWith(
          myChatRoomConnectionStatus: MyChatRoomConnectionStatus.disconnected);
  }
}
