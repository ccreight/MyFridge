
package com.FoodAPI;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Params {

    private List<Object> sane = null;
    private List<String> q = null;
    private List<String> from = null;
    private List<String> to = null;
    private List<String> appKey = null;
    private List<String> appId = null;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    public List<Object> getSane() {
        return sane;
    }

    public void setSane(List<Object> sane) {
        this.sane = sane;
    }

    public List<String> getQ() {
        return q;
    }

    public void setQ(List<String> q) {
        this.q = q;
    }

    public List<String> getFrom() {
        return from;
    }

    public void setFrom(List<String> from) {
        this.from = from;
    }

    public List<String> getTo() {
        return to;
    }

    public void setTo(List<String> to) {
        this.to = to;
    }

    public List<String> getAppKey() {
        return appKey;
    }

    public void setAppKey(List<String> appKey) {
        this.appKey = appKey;
    }

    public List<String> getAppId() {
        return appId;
    }

    public void setAppId(List<String> appId) {
        this.appId = appId;
    }

    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
