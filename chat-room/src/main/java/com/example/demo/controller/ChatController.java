package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.ChatMessageDto;

@Controller
public class ChatController {
	private List<ChatMessageDto> messages;

	ChatController() {
		messages = new ArrayList<>();
	}

	@RequestMapping("/chat/main")
	public String showMain() {
		return "chat/main";
	}

	@RequestMapping("/chat/addMessage")
	@ResponseBody
	public Map addMessage(String writer, String body) {
		long id = messages.size();
		ChatMessageDto newChatMessage = new ChatMessageDto(id, writer, body);
		messages.add(newChatMessage);

		Map<String, Object> rs = new HashMap<>();

		rs.put("msg", "채팅 메세지가 추가되었습니다.");
		rs.put("resultCode", "S-1");
		rs.put("addedMessage", newChatMessage);

		return rs;
	}

	@RequestMapping("/chat/getAllMessages")
	@ResponseBody
	public List<ChatMessageDto> getAllMessages() {
		return messages;
	}

	@RequestMapping("/chat/getMessages")
	@ResponseBody
	public List<ChatMessageDto> getMessagese(int from) {
		return messages.subList(from, messages.size());
	}
	
	@RequestMapping("/chat/clearMessages")
	@ResponseBody
	public Map cleatMessages() {
		messages.clear();
		
		Map<String, Object> rs = new HashMap<String, Object>();
		rs.put("msg", "모든 메세지가 삭제되었습니다.");
		rs.put("resultCode", "S-1");
		
		return rs;
	}
}
