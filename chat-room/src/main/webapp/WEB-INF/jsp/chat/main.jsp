<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js">
	
</script>
<script>
	var Chat__lastReceivedId = -1;

	function Chat__drawMessage(chatMessage) {
		var html = '';

		html += "<div>" + chatMessage.writer + ":" + chatMessage.body
				+ "</div>";

		$('.chat-messages').prepend(html);
	}

	function Chat__loadNewMessages() {
		$.get(
			'./getMessages',
			{
				from : Chat__lastReceivedId + 1
			},
			function(chatMessages) {
				for (var i = 0; i < chatMessages.length; i++) {
					var chatMessage = chatMessages[i];

					if (chatMessage.id > Chat__lastReceivedId) {
						Chat__drawMessage(chatMessage);
					}
				}

				if (chatMessages.length > 0) {
					Chat__lastReceivedId = chatMessages[chatMessages.length - 1].id;
				}

				setTimeout(Chat__loadNewMessages, 1000);
			}, 'json');
	}

	$(function() {
		Chat__loadNewMessages();
	});

	function Chat__sendMessage(form) {
		form.writer.value = form.writer.value.trim();

		if (form.writer.value.length == 0) {
			alert('작성자를 입력해 주세요.');
			form.writer.focus();

			return false;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('내용을 입력해 주세요.');
			form.body.focus();

			return false;
		}

		$.post('./addMessage', {
			writer : form.writer.value,
			body : form.body.value
		}, function(data) {

		}, 'json');

		form.body.value = '';
		form.body.focus();
	}
</script>
</head>
<body>
	<h1>채팅</h1>

	<form onsubmit="Chat__sendMessage(this); return false;">
		<input autocomplete="off" type="text" name="writer" placeholder="작성자">
		<input autocomplete="off" type="text" name="body" placeholder="내용">
		<input type="submit" value="전송">
	</form>

	<div class="chat-messages"></div>
</body>
</html>