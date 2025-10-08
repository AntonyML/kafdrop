<#--
 Copyright 2021 Kafdrop contributors.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 http://www.apache.org/licenses/LICENSE-2.0
-->
<#import "/spring.ftl" as spring />

<div class="pb-2 mt-5 mb-4 border-bottom" style="border-color:#6ACFC7;">
    <div class="container">
        <div class="container-fluid pl-0">
            <div id="header-title-line" class="row" style="background-color:#0C1A1A; padding:1em 0; border-radius:8px;">
                
                <!-- LOGO -->
                <div id="logo" class="col-md-1">
                    <img alt="logo" height="100%" src="<@spring.url '/images/kafdrop-logo.svg'/>"/>
                </div>
                
                <!-- TÍTULO -->
                <div id="title" class="col-md-9">
                    <h1 class="app-name brand mb-0">
                        <a href="<@spring.url '/'/>" style="color:#6ACFC7; text-decoration:none;">Kafdrop</a>
                    </h1>
                    <small style="color:#ffffff;">Forkeado y personalizado por Antony Monge López</small>
                </div>
                
                <!-- GITHUB STAR ORIGINAL -->
                <div id="github-star" class="col-md-2 text-right">
                    <a class="github-button" href="https://github.com/AntonyML/kafdrop" data-show-count="false"
                    aria-label="Star AntonyML Kafdrop on GitHub" data-color-scheme="dark"
                    style="color:#6ACFC7;">Star</a>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        setTimeout(function() { restyle(0); });
    });

    function restyle(retries) {
        var githubStarSpan = document.querySelector('#github-star span');
        if (githubStarSpan != null) {
            var shadowRoot = githubStarSpan.shadowRoot;
            if(shadowRoot) {
                shadowRoot.querySelector('.btn')
                    .setAttribute('style', 'color:#6ACFC7; background-image:none; background-color:#0C1A1A; border-color:#6ACFC7');
                shadowRoot.querySelector('.social-count')
                    .setAttribute('style', 'color:#ffffff; background-image:none; background-color:#6ACFC7; border-color:#6ACFC7');
                shadowRoot.querySelector('.social-count b')
                    .setAttribute('style', 'border-right-color:#6ACFC7');
                shadowRoot.querySelector('.social-count i')
                    .setAttribute('style', 'border-right-color:#6ACFC7');
            }
        } else {
            setTimeout(function() { restyle(retries + 1); }, retries * 10);
        }
    }
</script>
