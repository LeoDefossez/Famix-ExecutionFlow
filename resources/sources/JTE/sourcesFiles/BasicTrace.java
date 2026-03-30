package com.example;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BasicTrace {

	public static void main(String[] args) {
		List<String> l = new ArrayList<>();
		int monCompteur = 0;
		addAnElement(l);
	}

	public static void addAnElement(List<String> l) {
		l.add("AnElement");
		addAnotherElement(l);
	}

	public static void addAnotherElement(List<String> l) {
		l.add("AnotherElement");
		wowAnElementWasAdded(l);
	}

	public static void wowAnElementWasAdded(List<String> l) {
		try {
			Runtime.getRuntime().exec("cd");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
