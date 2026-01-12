package com.sample.backend.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class TestController {

    @GetMapping("/data")
    public Map<String, String> getData() {
        Map<String, String> data = new HashMap<>();
        data.put("message", "Hello from Spring Boot!");
        data.put("status", "success");
        return data;
    }
}
