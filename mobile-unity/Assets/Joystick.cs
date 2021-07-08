using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Joystick : MonoBehaviour
{
    public Animator ani;
    public Transform player;
    public float speed = 5.0f;
    private bool touchStart = false;
    private Vector2 pointA;
    private Vector2 pointB;
    private bool moving = false;

    public Transform circle;
    public Transform outerCircle;

    void Update()
    {
        if (Input.GetMouseButtonDown(0) && Input.mousePosition.x < Screen.width / 2) 
        {
            pointA = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, Camera.main.transform.position.z));

            circle.transform.position = pointA * 1;
            outerCircle.transform.position = pointA * 1;
            circle.GetComponent<SpriteRenderer>().enabled = true;
            outerCircle.GetComponent<SpriteRenderer>().enabled = true;
            moving = true;
        }
        if (Input.GetMouseButton(0) && moving)
        {
            if (Input.mousePosition.x < Screen.width / 2)
            {
                touchStart = true;
                moving = true;
                pointB = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, Camera.main.transform.position.z));
            }
        }
        else
        {
            moving = false;
            touchStart = false;
        }

    }
    private void FixedUpdate()
    {
        if (touchStart)
        {
            Vector2 offset = pointB - pointA;
            Vector2 direction = Vector2.ClampMagnitude(offset, 1.0f);
            moveCharacter(direction * 1);
            ani.SetBool("Walk", true);
            ani.SetBool("Idle1", false);
            circle.transform.position = new Vector2(pointA.x + direction.x, pointA.y + direction.y) * 1;
        }
        else
        {
            circle.GetComponent<SpriteRenderer>().enabled = false;
            outerCircle.GetComponent<SpriteRenderer>().enabled = false;
            ani.SetBool("Walk", false);
            ani.SetBool("Idle1", true);
            moving = false;
        }

    }
    void moveCharacter(Vector2 direction)
    {
        player.Translate(direction * speed * Time.deltaTime);
    }
    public void attackButton()
    {
        ani.SetTrigger("Attack");
    }
}