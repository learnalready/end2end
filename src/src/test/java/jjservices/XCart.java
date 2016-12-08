package jjservices;


import junit.framework.TestCase;

import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;


/**
 * Unit test for simple App.
 */
public class XCart {

    @Test
    public void loginXCart() throws Exception{
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.get("https://demostore.x-cart.com");
        driver.findElement(By.id("substring-default")).sendKeys("Selenium");
        driver.close();
    }
}
