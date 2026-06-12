package com.quiz.model;

import java.sql.Date;
import java.sql.Time;

public class ScheduledQuiz {
    private int quizId;
    private String quizTitle;
    private String subject;
    private String topic;
    private Date quizDate;
    private Time quizTime;
    private int duration;
    private int totalMarks;
    private boolean canStart;
    private String status;

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuizTitle() {
        return quizTitle;
    }

    public void setQuizTitle(String quizTitle) {
        this.quizTitle = quizTitle;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public Date getQuizDate() {
        return quizDate;
    }

    public void setQuizDate(Date date) {
        this.quizDate = date;
    }

    public Time getQuizTime() {
        return quizTime;
    }

    public void setQuizTime(Time time) {
        this.quizTime = time;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(int totalMarks) {
        this.totalMarks = totalMarks;
    }

    public boolean isCanStart() {
        return canStart;
    }

    public void setCanStart(boolean canStart) {
        this.canStart = canStart;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
   
}