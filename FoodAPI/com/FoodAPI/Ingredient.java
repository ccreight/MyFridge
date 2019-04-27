
package com.FoodAPI;

import java.util.HashMap;
import java.util.Map;

public class Ingredient {

    private String text;
    private Double weight;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
