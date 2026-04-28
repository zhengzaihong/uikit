import 'package:flutter/material.dart';
import 'package:uikit_plus/animation/splash_bobble_animation.dart';

class SplashBobbleDemo extends StatelessWidget {
  const SplashBobbleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashBobbleAnimation 演示'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDemoCard(
            context,
            title: '1. 默认配置',
            description: '使用默认的红、紫、黄、蓝四色气泡',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '2. 自定义颜色',
            description: '使用品牌色：蓝、绿、橙、粉',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                bubbleColors: const [
                  Color(0xFF6C63FF),
                  Color(0xFF4CAF50),
                  Color(0xFFFF9800),
                  Color(0xFFE91E63),
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '3. 渐变色系',
            description: '使用柔和的渐变色系',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                bubbleColors: const [
                  Color(0xFFFF6B6B),
                  Color(0xFF4ECDC4),
                  Color(0xFFFFE66D),
                  Color(0xFF95E1D3),
                ],
                backgroundColor: Color(0xFFF7F7F7),
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '4. 深色主题',
            description: '深色背景配亮色气泡',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                bubbleColors: const [
                  Color(0xFF00D9FF),
                  Color(0xFF00FFA3),
                  Color(0xFFFF00E5),
                  Color(0xFFFFD600),
                ],
                backgroundColor: Color(0xFF1A1A2E),
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '5. 大轨迹弧度',
            description: '增大运动轨迹弧度',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                motionCurveRadius: 150,
                bubbleColors: const [
                  Colors.pink,
                  Colors.cyan,
                  Colors.amber,
                  Colors.teal,
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '6. 大气泡',
            description: '增大气泡半径和缩放因子',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                bobbleRadius: 15,
                scaleFactor: 10.0,
                bubbleColors: const [
                  Colors.deepOrange,
                  Colors.indigo,
                  Colors.lime,
                  Colors.pinkAccent,
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '7. 禁用透明度',
            description: '气泡保持不透明',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                enableOpacity: false,
                bubbleColors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '8. 禁用缩放',
            description: '气泡大小保持不变',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                enableScale: false,
                bubbleColors: const [
                  Colors.purple,
                  Colors.teal,
                  Colors.amber,
                  Colors.pink,
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '9. 弹跳效果',
            description: '使用弹跳动画曲线',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2500),
                curve: Curves.bounceOut,
                bubbleColors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.yellow,
                  Colors.green,
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '10. 自定义气泡配置',
            description: '每个气泡使用不同的大小',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 2000),
                bubbles: const [
                  BubbleConfig(
                    color: Colors.red,
                    startAngle: 0,
                    radius: 20,
                  ),
                  BubbleConfig(
                    color: Colors.blue,
                    startAngle: 90,
                    radius: 15,
                  ),
                  BubbleConfig(
                    color: Colors.green,
                    startAngle: 180,
                    radius: 10,
                  ),
                  BubbleConfig(
                    color: Colors.orange,
                    startAngle: 270,
                    radius: 18,
                  ),
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '11. 快速动画',
            description: '1.5秒快速完成',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastOutSlowIn,
                bubbleColors: const [
                  Colors.deepPurple,
                  Colors.cyan,
                  Colors.amber,
                  Colors.pink,
                ],
              ),
            ),
          ),
          
          _buildDemoCard(
            context,
            title: '12. 慢速动画',
            description: '4秒慢速完成',
            onTap: () => _showDemo(
              context,
              SplashBobbleAnimation(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 4000),
                curve: Curves.easeInOutCubic,
                bubbleColors: const [
                  Colors.indigo,
                  Colors.teal,
                  Colors.orange,
                  Colors.pink,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showDemo(BuildContext context, Widget animation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _DemoScreen(animation: animation),
      ),
    );
  }
}

class _DemoScreen extends StatelessWidget {
  final Widget animation;

  const _DemoScreen({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          animation,
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black54),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text('返回'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
