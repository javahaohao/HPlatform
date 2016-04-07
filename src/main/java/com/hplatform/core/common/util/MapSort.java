package com.hplatform.core.common.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class MapSort {
	/** 
     * 使用 Map按key进行排序 
	 * @param <K>
	 * @param <V>
     * @param map 
     * @return 
     */  
    public static <K, V> Map<K, V> sortMapByKey(Map<K, V> map) {
        if (map == null || map.isEmpty()) {  
            return null;  
        }  
        Map<K, V> sortMap = new TreeMap<K, V>(new Comparator<K>() {
			public int compare(K o1, K o2) {
				return String.valueOf(o1).compareTo(String.valueOf(o2));
			}
		});  
        sortMap.putAll(map);  
        return sortMap;  
    }
    /** 
     * 使用 Map按value进行排序 
     * @param map 
     * @return 
     */  
    public static <K, V> Map<K, V> sortMapByValue(Map<K, V> map) {  
        if (map == null || map.isEmpty()) {  
            return null;  
        }  
        Map<K, V> sortedMap = new LinkedHashMap<K, V>();  
        List<Map.Entry<K, V>> entryList = new ArrayList<Map.Entry<K, V>>(map.entrySet());  
        Collections.sort(entryList, new Comparator<Map.Entry<K, V>>() {
			public int compare(Map.Entry<K, V> o1, Map.Entry<K, V> o2) {
				return String.valueOf(o1.getValue()).compareTo(String.valueOf(o2.getValue())); 
			}
		});  
        Iterator<Map.Entry<K, V>> iter = entryList.iterator();  
        Map.Entry<K, V> tmpEntry = null;  
        while (iter.hasNext()) {  
            tmpEntry = iter.next();  
            sortedMap.put(tmpEntry.getKey(), tmpEntry.getValue());  
        }  
        return sortedMap;  
    }  
}
