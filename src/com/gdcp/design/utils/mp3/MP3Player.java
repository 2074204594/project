package com.gdcp.design.utils.mp3;

import javazoom.jl.player.Player;

import java.io.BufferedInputStream;
import java.io.FileInputStream;

public class MP3Player {
    private String filename;
    private Player player;

    public MP3Player(String filename) {
        this.filename = filename;
    }

    public void play() {
        try {
            BufferedInputStream buffer = new BufferedInputStream(new FileInputStream(filename));
            player = new Player(buffer);
            player.play();

        } catch (Exception e) {
            System.out.println(e);
        }
    }


}