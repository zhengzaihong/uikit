/*
* Copyright (c) 2024 Hunan OpenValley Digital Industry Development Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Log from '../../../util/Log';
import DartExecutor from '../dart/DartExecutor';
import BasicMessageChannel, { MessageHandler, Reply} from '../../../plugin/common/BasicMessageChannel';
import HashMap from '@ohos.util.HashMap';
import StandardMessageCodec from '../../../plugin/common/StandardMessageCodec';
import StringUtils from '../../../util/StringUtils';
import Any from '../../../plugin/common/Any';
import FlutterNapi from '../FlutterNapi';

/**
* nativeVsync功能channel
*/
export default class NativeVsyncChannel implements MessageHandler<object> {
    private static TAG = "NativeVsyncChannel";
    private static CHANNEL_NAME = "flutter/nativevsync";
    private channel: BasicMessageChannel<object>;
    private flutterNapi: FlutterNapi;

    onMessage(message: object, reply: Reply<object>): void {
        let data: HashMap<string, Any> = message as HashMap<string, Any>;
        let isEnable: boolean = data.get("isEnable");
        this.flutterNapi.SetDVsyncSwitch(isEnable);

        Log.d(NativeVsyncChannel.TAG, `Received message: isEnable:$isEnable`);
        reply.reply(StringUtils.stringToArrayBuffer(""));
    }

    constructor(dartExecutor: DartExecutor, flutterNapi: FlutterNapi) {
        Log.i(NativeVsyncChannel.TAG, "Channel entered");
        this.channel = new BasicMessageChannel<object>(
            dartExecutor, NativeVsyncChannel.CHANNEL_NAME, StandardMessageCodec.INSTANCE);
        this.channel.setMessageHandler(this);
        this.flutterNapi = flutterNapi;
    }
}