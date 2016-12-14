# README

[![Build Status](https://travis-ci.org/rems-palyvoda/Cactus.svg?branch=master)](https://travis-ci.org/rems-palyvoda/Cactus)

This README would normally document whatever steps are necessary to get the
application up and running.

Start:

<pre>$ rails server</pre>

<div>
<strong>User story:</strong>
You need to build a simple social network (call it as you want).
  <ol>
    <li>
      *0.* On a root page of your Social Network (SN) as a Guest (as an unauthorized user) I can see only a Registration form and a prompt to Sign In. As an already authorized Member I can see my own account page.
    </li>
    <li>
      *1.* My own account page consists of:
      <ul>
        <li>
          a) a section with 8 - 10 minified thumbnails of images from my gallery (in the random order) with the link to my Gallery page, where all images are shown as an endless scroll;
        </li>
        <li>
          b) a section with 8 - 10 list of my ‘friends’ described by their avatars (in the random order) with the link to my Friends page, where all users are shown as an endless scroll,
        </li>
        <li>
          c) a section with my account (personal) info with the “Edit” link which takes me to the Account editing page but only if it’s my own account (I can’t modify someone else’s personal account info),
        </li>
        <li>
          d) the rest of the area of the page is my news feed, where news of my own and my friends are shown in descent order (the latest news on top), also as an endless scroll.
        </li>
      </ul>
    </li>
    <li>
      *2.* News can be:
      a) a cell with an image with or without title/description. All images that user adds (uploads) as a news are stored in his/her gallery,
      b) a cell with a text with 200 characters limit,
      c) a cell with a link to Youtube video (all other links to external resources are restricted). When User adds a link to Youtube video this news cell shows the embedded youtube’s player with this video.
    </li>
    <li>
      *3.* Relationships.
      Users can have relationships between each other. So you need to provide a mechanism which will allow users to add other users as friends (if you’ll take Hartl’s tutorial as a basis (‘followers’ in his twitter clone) - it’s ok).
    </li>
  </ol>
</div>