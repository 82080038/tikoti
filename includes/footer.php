    </main>
    
    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><?php echo APP_NAME; ?></h5>
                    <p class="mb-0">Platform togel online terpercaya dan aman.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">&copy; <?php echo date('Y'); ?> <?php echo APP_NAME; ?>. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>
    
    <script>
    const BASE_URL = '<?php echo BASE_URL; ?>';
    
    function logout() {
        if (confirm('Apakah Anda yakin ingin logout?')) {
            window.location.href = BASE_URL + '/api/index.php?endpoint=auth&action=logout';
        }
    }
    </script>
</body>
</html>
