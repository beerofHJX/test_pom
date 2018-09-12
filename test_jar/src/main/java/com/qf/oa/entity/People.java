package com.qf.oa.entity;

/**
 *
 */
public class People {
    private Integer allpeople;
    private  Integer women;
    private  Integer man;

    @Override
    public String toString() {
        return "Number{" +
                "allpeople=" + allpeople +
                ", women=" + women +
                ", man=" + man +
                '}';
    }

    public Integer getAllpeople() {
        return allpeople;
    }

    public void setAllpeople(Integer allpeople) {
        this.allpeople = allpeople;
    }

    public Integer getWomen() {
        return women;
    }

    public void setWomen(Integer women) {
        this.women = women;
    }

    public Integer getMan() {
        return man;
    }

    public void setMan(Integer man) {
        this.man = man;
    }
}
